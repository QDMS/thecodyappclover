import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/screens/wishlist/wishlist_widget.dart';
import 'package:thecodyapp/storeApp/screens/wishlist/below_wishlist_app_bar.dart';
import 'package:thecodyapp/storeApp/widgets/empty_wishlist_screen.dart';

class WishlistScreen extends StatefulWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
  final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    
      return wishlistItemsList.isEmpty ? const EmptyWishlistScreen()
      : Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: const Icon(
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
        body: Column(
          children: [
            const BelowWishlistAppBar(),
            Expanded(
              child: MasonryGridView.count(
                itemCount: wishlistItemsList.length,
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
                },
              ),
            ),
          ],
        ),
      );
    }
  }
