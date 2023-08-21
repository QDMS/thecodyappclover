import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:thecodyapp/storeApp/providers/viewed_provider.dart';
import 'package:thecodyapp/storeApp/screens/viewed_recently/below_viewed_recently_app_bar.dart';
import 'package:thecodyapp/storeApp/screens/viewed_recently/viewed_widget.dart';
import 'package:thecodyapp/storeApp/widgets/empty_viewed_screen.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  State<ViewedRecentlyScreen> createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    final viewedProductProvider = Provider.of<ViewedProductProvider>(context);
    final viewedProductItemsList = viewedProductProvider
        .getViewedProdlistItems.values
        .toList()
        .reversed
        .toList();

    if (viewedProductItemsList.isEmpty) {
      return const EmptyViewedScreen();
    } else {
      return Scaffold(
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
            const BelowViewedRecentlyAppBar(),
            Expanded(
              child: ListView.separated(
                itemCount: viewedProductItemsList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: ChangeNotifierProvider.value(
                        value: viewedProductItemsList[index],
                        child: const ViewedRecentlyWidget()),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.white,
                    thickness: 1,
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
