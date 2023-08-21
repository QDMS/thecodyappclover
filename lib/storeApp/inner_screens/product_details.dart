import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/providers/viewed_provider.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/widgets/heart_btn.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

import '../providers/products_provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct = productProvider.findProdById(productId);
    
    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);
    double usedPrice = getCurrentProduct.isOnSale
        ? getCurrentProduct.salePrice
        : getCurrentProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    final viewedProductProvider = Provider.of<ViewedProductProvider>(context);
    final whatUnit = getCurrentProduct.isPiece
        ? 'Piece'
        : getCurrentProduct.isMonth
            ? 'Month'
            : 'Kg';
    return WillPopScope(
      onWillPop: () async {
        viewedProductProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(
              IconlyLight.arrowLeft2,
              color: tabLabelColor,
              size: 24,
            ),
          ),
          elevation: 0.25,
          centerTitle: true,
          automaticallyImplyLeading: false,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 8.0),
          //     child: IconButton(
          //       icon: const Icon(
          //         IconlyLight.chat,
          //         color: tabLabelColor,
          //         size: 30,
          //       ),
          //       onPressed: () => Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const MobileChatScreenLayout(),
          //         ),
          //       ),
          //     ),
          //   ),
          // ],
          title: Image.asset(
            Constants.storeAppBarLogo,
            height: 55,
          ),
        ),
        body: Column(children: [
          Flexible(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                imageUrl: getCurrentProduct.imageUrl,
                boxFit: BoxFit.scaleDown,
                width: size.width,
                // height: screenHeight * .4,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: TextWidget(
                            text: getCurrentProduct.title,
                            color: Colors.white,
                            textSize: 25,
                            isTitle: true,
                          ),
                        ),
                        HeartBTN(
                          productId: getCurrentProduct.id,
                          isInWishlist: _isInWishlist,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '\$${usedPrice.toStringAsFixed(2)}',
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        TextWidget(
                          text: '/',
                          color: Colors.white,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        TextWidget(
                          text: whatUnit,
                          color: Colors.white,
                          textSize: 12,
                          isTitle: false,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: getCurrentProduct.isOnSale ? true : false,
                          child: Text(
                            '\$${getCurrentProduct.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough),
                          ),
                        ),
                        const Spacer(),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       vertical: 4, horizontal: 8),
                        //   decoration: BoxDecoration(
                        //       color: const Color.fromRGBO(63, 200, 101, 1),
                        //       borderRadius: BorderRadius.circular(5)),
                        //   child: TextWidget(
                        //     text: 'Free delivery',
                        //     color: Colors.white,
                        //     textSize: 20,
                        //     isTitle: true,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      quantityControl(
                        fct: () {
                          if (_quantityTextController.text == '1') {
                            return;
                          } else {
                            setState(() {
                              _quantityTextController.text =
                                  (int.parse(_quantityTextController.text) - 1)
                                      .toString();
                            });
                          }
                        },
                        icon: CupertinoIcons.minus,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _quantityTextController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityTextController.text = '1';
                              } else {}
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      quantityControl(
                        fct: () {
                          setState(() {
                            _quantityTextController.text =
                                (int.parse(_quantityTextController.text) + 1)
                                    .toString();
                          });
                        },
                        icon: CupertinoIcons.plus,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    decoration: const BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Total',
                                color: Colors.red.shade300,
                                textSize: 20,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Row(
                                  children: [
                                    TextWidget(
                                      text:
                                          '\$${totalPrice.toStringAsFixed(2)}',
                                      color: Colors.white,
                                      textSize: 20,
                                      isTitle: true,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    TextWidget(
                                      text: '/',
                                      color: Colors.white,
                                      textSize: 22,
                                      isTitle: true,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    TextWidget(
                                      text: _quantityTextController.text,
                                      color: Colors.white,
                                      textSize: 16,
                                      isTitle: true,
                                    ),
                                    TextWidget(
                                      text: whatUnit,
                                      color: Colors.white,
                                      textSize: 15,
                                      isTitle: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: isInCart
                                  ? null
                                  : () async {
                                      // if (_isInCart) {
                                      //   return;
                                      // }
                                      final User? user =
                                          authInstance.currentUser;
                                      if (user == null) {
                                        GlobalMethods.errorDialog(
                                            subtitle:
                                                'No User Found, Please Sign In or Create An Account.',
                                            context: context);
                                        return;
                                      }
                                     await GlobalMethods.addToCart(
                                          productId: getCurrentProduct.id,
                                          quantity: int.parse(
                                              _quantityTextController.text),
                                          context: context);
                                           await cartProvider.fetchCart();
                                      // cartProvider.addProductsToCart(
                                      //     productId: getCurrentProduct.id,
                                      //     quantity: int.parse(
                                      //         _quantityTextController.text));
                                    },
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                      text:
                                          isInCart ? 'In Cart' : 'Add to cart',
                                      color: Colors.white,
                                      textSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
