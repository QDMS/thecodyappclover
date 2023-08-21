import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/storeApp/widgets/empty_screen.dart';

class EmptyWishlistScreen extends StatelessWidget {
  const EmptyWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.25,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: tabLabelColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Image.asset(
          Constants.storeAppBarLogo,
          height: 55,
        ),
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
      ),
      body: const EmptyScreen(
        title: 'Your Wishlist Is Empty!',
        subtitle: 'Explore More And Shortlist Some Items :)',
        buttonText: 'Add A Wish',
        imagePath: 'assets/wishlist.png',
      ),
    );
  }
}
