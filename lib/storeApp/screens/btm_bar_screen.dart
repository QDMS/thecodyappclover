import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart'
    show IconlyBold, IconlyLight;
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:thecodyapp/storeApp/providers/cart_provider.dart';
import 'package:thecodyapp/storeApp/screens/cart/cart_screen.dart';
import 'package:thecodyapp/storeApp/screens/categories_screen.dart';
import 'package:thecodyapp/storeApp/screens/home_screen.dart';
import 'package:thecodyapp/storeApp/screens/user_screen.dart';
import 'package:badges/badges.dart' as badges;

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': CategoriesScreen(), 'title': 'Categories Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
    {'page': const UserScreen(), 'title': 'User Screen'},
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
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
        //       onPressed: () => Navigator.of(context).pop(),
        //     ),
        //   ),
        // ],
        title: Container(
         width: 80,
          height: 55,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                Constants.storeAppBarLogo
            )),
          ),
        ),
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: tabColor,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          unselectedItemColor: tabLabelColor,
          selectedItemColor: tabLabelColor,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Consumer<CartProvider>(builder: (_, myCart, ch) {
                return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -10, end: -12),
                    showBadge: true,
                    ignorePointer: false,
                    onTap: () {},
                    badgeContent: FittedBox(
                      child: Text(
                        myCart.getCartItems.length.toString(),
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    badgeAnimation: const badges.BadgeAnimation.rotation(
                        toAnimate: true,
                        animationDuration: Duration(
                          seconds: 10,
                        )),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: tabColor,
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.transparent, width: 2),
                      borderGradient: const badges.BadgeGradient.linear(
                          colors: [Colors.black, Colors.white]),
                      badgeGradient: const badges.BadgeGradient.linear(
                        colors: [tabColor, tabLabelColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      elevation: 0,
                    ),
                    child: Icon(_selectedIndex == 2
                        ? IconlyBold.buy
                        : IconlyLight.buy));
              }),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'User',
            ),
          ]),
    );
  }
}
