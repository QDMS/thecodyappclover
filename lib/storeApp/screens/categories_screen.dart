// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:thecodyapp/storeApp/widgets/categories_widget.dart';


class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({super.key});

  List<Color> gridColor = [
    const Color.fromRGBO(237, 83, 20, 1),
    const Color.fromRGBO(255, 185, 42, 1),
    const Color.fromRGBO(254, 235, 81, 1),
    const Color.fromRGBO(230, 230, 230, 1),
    const Color.fromRGBO(58, 187, 201, 1),
    const Color.fromRGBO(155, 202, 62, 1),
    
  ];
  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/members.png',
      'catText': 'Members',
    },
    {
      'imgPath': 'assets/tv.png',
      'catText': 'TVs',
    },
    {
      'imgPath': 'assets/computers.png',
      'catText': 'Computers',
    },
    {
      'imgPath': 'assets/gadgets.png',
      'catText': 'Miscellaneous',
    },
    {
      'imgPath': 'assets/network.png',
      'catText': 'Network',
    },
    {
      'imgPath': 'assets/he.png',
      'catText': 'Home Entertainment',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 240 / 250,
        crossAxisSpacing: 15,
        mainAxisSpacing: 30,
        children: List.generate(6, (index) {
          return CategoriesWidget(
            catText: catInfo[index]['catText'],
            imgPath: catInfo[index]['imgPath'],
            color: gridColor[index],
          );
        }),
      ),
    ));
  }
}
