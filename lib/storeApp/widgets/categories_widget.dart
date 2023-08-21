// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:thecodyapp/storeApp/inner_screens/cat_screen.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.color})
      : super(key: key);

  String catText, imgPath;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () {
            Navigator.pushNamed(context, CategoryScreen.routeName, arguments: catText);
          },
      child: Container(
        // height: _screenWidth * 0.6,
        decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.7), width: 2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenWidth * 0.3,
              width: screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath),
                    fit: BoxFit.fill),
              ),
            ),
            TextWidget(
              text: catText,
              color: Colors.white,
              textSize: 20,
              isTitle: true,
            )
          ],
        ),
      ),
    );
  }
}
