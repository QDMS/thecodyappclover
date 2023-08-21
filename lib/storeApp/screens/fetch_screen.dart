import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/widgets/loader.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/providers/products_provider.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/screens/btm_bar_screen.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final productProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishlistProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final User? user = authInstance.currentUser;
      if (user == null) {
        await productProvider.fetchProducts();
        cartProvider.clearLocalCart();
        wishlistProvider.clearLocalWishlist();
      } else {
        await productProvider.fetchProducts();
        await cartProvider.fetchCart();
        await wishlistProvider.fetchWishlist();
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BottomBarScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/navBarLogo.png',
            fit: BoxFit.contain,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
            child: const Loader(),
          ),
        ],
      ),
    );
  }
}
