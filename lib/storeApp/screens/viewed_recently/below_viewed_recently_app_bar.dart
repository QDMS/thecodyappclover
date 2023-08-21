import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class BelowViewedRecentlyAppBar extends StatelessWidget {
  const BelowViewedRecentlyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     color: appBarColor,
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: TextWidget(
            text: 'History',
            color: tabLabelColor,
            textSize: 24,
            isTitle: true,
                  ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                  title: 'Empty Your History?',
                  subtitle: 'Are You Sure?',
                  fct: () {},
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
