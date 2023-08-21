import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
      width: 30,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          backgroundColor: tabLabelColor,
          valueColor:AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
