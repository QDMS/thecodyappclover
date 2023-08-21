import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thecodyapp/chatApp/common/utils/utils.dart';
import 'package:thecodyapp/chatApp/common/widgets/custom_button.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/features/auth/controller/auth_controller.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:country_picker/country_picker.dart';

class ChatLoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/ChatLoginScreen';
  const ChatLoginScreen({super.key});

  @override
  ConsumerState<ChatLoginScreen> createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends ConsumerState<ChatLoginScreen> {
  final phoneController = TextEditingController();
  Country? country;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country _country) {
        setState(
          () {
            country = _country;
          },
        );
      },
    );
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.25,
        backgroundColor: backgroundColor,
        title: const Text(
          'Enter Your Phone Number',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 120,
              ),
              const Text(
                'The Cody Chat will need to verify your phone number',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: pickCountry,
                child: const Text(
                  'Pick Your Country',
                  style: TextStyle(color: tabLabelColor, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    if (country != null)
                      Text(
                        '+${country!.phoneCode}',
                        style:
                            const TextStyle(color: tabLabelColor, fontSize: 18),
                      ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a valid phone number.';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: tabLabelColor, fontSize: 20,),
                        cursorColor: tabLabelColor,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: tabColor.withOpacity(.08),
                          prefixIcon: const Icon(
                            Icons.phone,
                            color: tabLabelColor,
                          ),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: tabLabelColor.withOpacity(.8),
                          ),
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
                            borderSide:
                                BorderSide(color: tabColor.withOpacity(.05)),
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
              SizedBox(
                height: size.height * 0.45,
              ),
              SizedBox(
                width: size.width * 0.45,
                child: CustomButton(
                  fct: sendPhoneNumber,
                  buttonText: 'NEXT',
                  primary: Colors.amberAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
