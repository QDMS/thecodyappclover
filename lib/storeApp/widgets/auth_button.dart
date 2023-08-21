import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.fct,
      required this.buttonText,
      this.primary = Colors.white38
      });

  final Function fct;
  final String buttonText;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
              backgroundColor: primary,
            ),
            onPressed: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextWidget(
                text: buttonText,
                color: tabLabelColor,
                textSize: 20,
                isTitle: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
