import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/widgets/loader.dart';
import 'package:thecodyapp/storeApp/screens/payment/success.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:dio/dio.dart';
import '../../../chatApp/common/utils/colors.dart';

class CheckoutMethodBank extends StatefulWidget {
  static const routeName = '/CheckoutMethodBank';

  final int? amount;
  const CheckoutMethodBank({this.amount = 67});
  @override
  _CheckoutMethodBankState createState() => _CheckoutMethodBankState();
}

class _CheckoutMethodBankState extends State<CheckoutMethodBank> {
  late final WebViewController controller;
  Dio dio = Dio();
  int koboAmount = 0;
  String _email = 'abumraj@gmail.com';
  String source = '';
  int position = 0;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('cody', onMessageReceived: (p0) {
        // sendChargeRequest(p0.message);
        print(p0.message);
        setState(() {
          source = p0.message;
          sendChargeRequest(source);
        });
      })
      ..addJavaScriptChannel('load', onMessageReceived: (p0) {
        setState(() {
          position = 0;
        });
      })
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            controller.runJavaScript(
                "document.getElementById('sb').innerHTML = 'Pay \$${widget.amount}';");
            controller.runJavaScript(
                "document.getElementById('sb').style.color = 'black';");
            controller.runJavaScript(
                "document.getElementById('sb').style.fontWeight = '700';");
            setState(() {
              position = 1;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://thecodyapp-backend-5c088.web.app'));

    koboAmount = widget.amount! * 100;
    super.initState();
  }

  Future<void> getUserData() async {
    if (user == null) {
      return;
    }
    String _uid = user!.uid;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('storeUsers')
        .doc(_uid)
        .get();
    setState(() {
      _email = userDoc.get('email');
    });
  }

  sendChargeRequest(source) async {
    try {
      final response = await dio.get(
          "https://us-central1-thecodyapp-backend-5c088.cloudfunctions.net/sendCloverChargeRequest?amount=$koboAmount&source=$source&email=$_email");

      if (response.data["paid"] == true &&
          response.data["status"] == "succeeded") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ThankYouPage()));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 500) {
        setState(() {
          position = 1;
        });
        _showChatPrivayPolicyDialog();
      }
    }
  }

  Future<void> _showChatPrivayPolicyDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                title: const Text('Payment not completed'),
                content: const Text(
                    "Unable to charge card. please provide valid information and try again"),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: tabLabelColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Car Details",
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: IndexedStack(index: position, children: <Widget>[
          Center(child: Loader()),
          WebViewWidget(controller: controller),
        ]));
  }
}
