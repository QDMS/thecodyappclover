import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/features/auth/controller/auth_controller.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class OTPScreen extends ConsumerWidget {
  static const String routeName = "/OTPScreen";
  final String verificationId;
  const OTPScreen({super.key, required this.verificationId});

  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.25,
        backgroundColor: backgroundColor,
        title: const Text(
          'Verifying Your Number',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: 'We Have Sent An SMS With A Code.',
              color: Colors.white,
              textSize: 20,
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: size.width * 0.5,
              child: TextFormField(
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: tabLabelColor,
                  fontSize: 30,
                ),
                cursorColor: tabLabelColor,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    verifyOTP(ref, context, val.trim());
                  }
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '- - - - - -',
                  hintStyle: const TextStyle(fontSize: 30),
                  filled: true,
                  fillColor: tabColor.withOpacity(.08),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: tabColor.withOpacity(.05),
                    ),
                    borderRadius: BorderRadius.circular(30).copyWith(
                      bottomRight: const Radius.circular(0),
                      topLeft: const Radius.circular(0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: tabColor.withOpacity(.05)),
                    borderRadius: BorderRadius.circular(30).copyWith(
                      bottomRight: const Radius.circular(0),
                      topLeft: const Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
