import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/providers/wishlist_provider.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class BelowWishlistAppBar extends StatelessWidget {
  const BelowWishlistAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return Container(
      color: appBarColor,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: TextWidget(
              text: 'Wishlist (${wishlistItemsList.length})',
              color: tabLabelColor,
              textSize: 22,
              isTitle: true,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Empty Your Wishlist?',
                  subtitle: 'Are You Sure?',
                  fct: () async {
                    await wishlistProvider.clearOnlineWishlist();
                    wishlistProvider.clearLocalWishlist();
                  },
                  context: context);
            },
            icon: const Icon(
              IconlyLight.delete,
              color: tabLabelColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
