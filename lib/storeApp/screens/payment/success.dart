import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/providers/orders_provider.dart';
import 'package:thecodyapp/storeApp/screens/fetch_screen.dart';
import 'package:uuid/uuid.dart';
import '../../../chatApp/common/utils/colors.dart';
import '../../providers/products_provider.dart';
import 'package:provider/provider.dart';

class ThankYouPage extends StatefulWidget {
  static const routeName = '/ThankYouPage';
  final String? title;

  const ThankYouPage({Key? key, this.title}) : super(key: key);

  @override
  State<ThankYouPage> createState() => _ThankYouPageState();
}

Color themeColor = const Color(0xFF43D19E);

class _ThankYouPageState extends State<ThankYouPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);
  bool isStarted = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.findProdById(value.productId);
      total += (getCurrentProduct.isOnSale
              ? getCurrentProduct.salePrice
              : getCurrentProduct.price) *
          value.quantity;
    });
    final User? user = authInstance.currentUser;

    cartProvider.getCartItems.forEach((key, value) async {
      // final _uid = user!.uid;
      final getCurrentProduct = productProvider.findProdById(value.productId);
      try {
        final orderId = Uuid().v4();
        await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
          'orderId': orderId,
          'userId': user!.uid,
          'productId': value.productId,
          'price': (getCurrentProduct.isOnSale
                  ? getCurrentProduct.salePrice
                  : getCurrentProduct.price) *
              value.quantity,
          'totalPrice': total,
          'quantity': value.quantity,
          'imageUrl': getCurrentProduct.imageUrl,
          'username': user.displayName,
          // 'phoneNumber': user.phoneNumber,
          'orderDate': Timestamp.now(),
        });
        await cartProvider.clearOnlineCart();
        cartProvider.clearLocalCart();
        ordersProvider.fetchOrders();
        await Fluttertoast.showToast(
            msg: "Your order has been placed.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: tabColor,
            textColor: tabLabelColor,
            fontSize: 16.0);
        setState(() {
          isStarted = false;
        });
      } catch (error) {
        GlobalMethods.errorDialog(subtitle: error.toString(), context: context);
      } finally {}
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/card.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Payment Successful",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Thank you",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Text(
              isStarted
                  ? "Placing your Order...."
                  : "Congratulations! Order placed successfully.\n Click below to return home",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Flexible(
              child: isStarted
                  ? Container()
                  : HomeButton(
                      title: 'Home',
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FetchScreen()));
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeButton extends StatelessWidget {
  HomeButton({Key? key, this.title, this.onTap}) : super(key: key);

  String? title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
