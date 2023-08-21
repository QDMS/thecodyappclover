// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/inner_screens/product_details.dart';
import 'package:thecodyapp/storeApp/models/products_model.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/widgets/heart_btn.dart';
import 'package:thecodyapp/storeApp/widgets/price_widget.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: FancyShimmerImage(
                      imageUrl: productModel.imageUrl,
                      height: size.width * 0.21,
                      width: size.width * 0.21,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextWidget(
                              text: productModel.title,
                              maxLines: 1,
                              color: Colors.white,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: HeartBTN(
                              productId: productModel.id,
                              isInWishlist: isInWishlist,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: PriceWidget(
                            salePrice: productModel.salePrice,
                            price: productModel.price,
                            textPrice: _quantityTextController.text,
                            isOnSale: productModel.isOnSale,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: [
                              FittedBox(
                                child: TextWidget(
                                  text: productModel.isPiece
                                      ? 'Piece'
                                      : productModel.isMonth
                                          ? 'Month'
                                          : "Kg",
                                  color: Colors.white,
                                  textSize: 12,
                                  isTitle: true,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: _quantityTextController,
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.green,
                                  enableInteractiveSelection: false,
                                  decoration: const InputDecoration(
                                      focusColor: tabLabelColor,
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: tabLabelColor, width: 2))),
                                  key: const ValueKey('10 \$'),
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Quantity Is Missed';
                                    }
                                    return null;
                                  },
                                  maxLines: 1,
                                  enabled: true,
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        // total = usedPrice * int.parse(_quantityTextController.text);
                                      }
                                    });
                                  },
                                  // onSaved: (value) {},
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9.,]'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: isInCart
                          ? null
                          : () async {
                              // if (_isInCart) {
                              //   return;
                              // }
                              final User? user = authInstance.currentUser;
                              if (user == null) {
                                GlobalMethods.errorDialog(
                                    subtitle:
                                        'No user found, Please Sign in or create an account.',
                                    context: context);
                                return;
                              }
                             await GlobalMethods.addToCart(
                                  productId: productModel.id,
                                  quantity: int.parse(
                                    _quantityTextController.text,
                                  ),
                                  context: context);
                                   await cartProvider.fetchCart();
                              // cartProvider.addProductsToCart(
                              //     productId: productModel.id,
                              //     quantity:
                              //         int.parse(_quantityTextController.text));
                            },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor,
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      child: TextWidget(
                        text: isInCart ? 'In Cart' : 'Add To Cart',
                        color: Colors.white,
                        textSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
