import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/constss.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/screens/loading_manager.dart';
import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';

class StoreForgetPasswordScreen extends StatefulWidget {
  static const routeName = '/StoreForgetPasswordScreen';
  const StoreForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _StoreForgetPasswordScreenState createState() =>
      _StoreForgetPasswordScreenState();
}

class _StoreForgetPasswordScreenState extends State<StoreForgetPasswordScreen> {
  final _emailTextController = TextEditingController();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains('@')) {
      GlobalMethods.errorDialog(
          subtitle: 'Please Enter A Correct Email Address!!!',
          context: context);
    } else {
      setState(() {
        _isLoading = true;
      });
    try {
       await authInstance.sendPasswordResetEmail(
          email: _emailTextController.text.toLowerCase()); 
          Fluttertoast.showToast(
        msg: "An Email Has Been Sent To Your Email Address.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: tabColor,
        textColor: tabLabelColor,
        fontSize: 16.0
    );
    }on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '${error.message}',
          context: context,
        );
      } catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '$error',
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.loginImages[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.loginImages.length,

              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.1,
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null,
                    child: const Icon(
                      IconlyLight.arrowLeft2,
                      color: tabLabelColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: 'Forget password',
                    color: tabColor,
                    textSize: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: _emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: tabLabelColor),
                    cursorColor: tabLabelColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: tabColor.withOpacity(.08),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: tabLabelColor,
                      ),
                      labelText: 'Enter your email',
                      labelStyle: TextStyle(
                        color: tabLabelColor.withOpacity(.8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: tabColor.withOpacity(.05),
                        ),
                        borderRadius: BorderRadius.circular(30).copyWith(
                          bottomRight: const Radius.circular(0),
                          topLeft: const Radius.circular(0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: tabColor.withOpacity(.05)),
                        borderRadius: BorderRadius.circular(30).copyWith(
                          bottomRight: const Radius.circular(0),
                          topLeft: const Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    buttonText: 'Reset now',
                    fct: () {
                      _forgetPassFCT();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
