import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/widgets/loader.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/storeApp/consts/constss.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/screens/fetch_screen.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeLogin.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeforgot_pass.dart';
import 'package:thecodyapp/storeApp/screens/loading_manager.dart';

import '../../widgets/auth_button.dart';
import '../../widgets/text_widget.dart';

class StoreRegisterScreen extends StatefulWidget {
  static const routeName = '/StoreStoreRegisterScreen';
  const StoreRegisterScreen({Key? key}) : super(key: key);

  @override
  State<StoreRegisterScreen> createState() => _StoreRegisterScreenState();
}

class _StoreRegisterScreenState extends State<StoreRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _phoneNumberTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _passVisibility = true;
  @override
  void dispose() {
    _phoneNumberTextController.dispose();
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passTextController.text.trim());
        final User? user = authInstance.currentUser;
        final _uid = user!.uid;
        user.updateDisplayName(_fullNameController.text);
        user.reload();
        await FirebaseFirestore.instance
            .collection('storeUsers')
            .doc(_uid)
            .set({
          'id': _uid,
          'name': _fullNameController.text,
          'email': _emailTextController.text.toLowerCase(),
          'phoneNumber': _phoneNumberTextController.text,
          'address': _addressTextController.text,
          'userWish': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });
        // if (context.mounted) {
        //   Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(
        //       builder: (context) => const FetchScreen(),
        //     ),
        //   );
        // }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              if (mounted) {
                return const FetchScreen();
              } else {
                return Container(); // Return an empty widget or handle the case when the widget is not mounted
              }
            },
          ),
        );

        print('Successfully Registered');
      } on FirebaseException catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '${error.message}',
          context: context,
        );
      } catch (error) {
        GlobalMethods.errorDialog(
          subtitle: '$error',
          context: context,
        );
        setState(() {
          _isLoading = false;
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: <Widget>[
            Swiper(
              duration: 800,
              autoplayDelay: 6000,

              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.loginImages[index],
                  fit: BoxFit.cover,
                );
              },
              autoplay: true,
              itemCount: Constss.loginImages.length,

              // control: const SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const SizedBox(
                    height: 60.0,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  TextWidget(
                    text: 'Welcome To',
                    color: Colors.white,
                    textSize: 30,
                    isTitle: true,
                  ),
                  RichText(
                    text: const TextSpan(
                      text: 'The',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                      children: [
                        TextSpan(
                          text: ' Cody',
                          style: TextStyle(
                              color: tabColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' Store',
                          style: TextStyle(
                              color: tabLabelColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextWidget(
                    text: "Sign Up To Continue",
                    color: Colors.white,
                    textSize: 18,
                    isTitle: false,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          controller: _fullNameController,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "This Field is missing";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: tabLabelColor),
                          cursorColor: tabLabelColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: tabColor.withOpacity(.08),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: tabLabelColor,
                            ),
                            labelText: 'Enter your name',
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          focusNode: _emailFocusNode,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passFocusNode),
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address.';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: tabLabelColor),
                          cursorColor: tabLabelColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: tabColor.withOpacity(.08),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: tabLabelColor,
                            ),
                            labelText: 'Enter your email',
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
                        const SizedBox(
                          height: 20,
                        ),
                        //Password
                        TextFormField(
                          focusNode: _passFocusNode,
                          obscureText: _passVisibility,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          controller: _passTextController,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 7) {
                              return 'Please enter a password more than 7 characters';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: tabLabelColor),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_addressFocusNode),
                          cursorColor: tabLabelColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: tabColor.withOpacity(.08),
                            suffixIcon: IconButton(
                              icon: _passVisibility
                                  ? const Icon(
                                      Icons.visibility_off,
                                      color: tabLabelColor,
                                    )
                                  : const Icon(
                                      Icons.visibility,
                                      color: tabLabelColor,
                                    ),
                              onPressed: () {
                                _passVisibility = !_passVisibility;

                                setState(() {});
                              },
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: tabLabelColor,
                            ),
                            labelText: 'Enter your password',
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
                        const SizedBox(
                          height: 20,
                        ),

                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _submitFormOnRegister,
                          controller: _phoneNumberTextController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter a phone number";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: tabLabelColor),
                          cursorColor: tabLabelColor,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: tabColor.withOpacity(.08),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: tabLabelColor,
                            ),
                            labelText: 'Enter your phone number',
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context,
                            routeName: StoreForgetPasswordScreen.routeName);
                      },
                      child: const Text(
                        'Forget password?',
                        maxLines: 1,
                        style: TextStyle(
                            color: tabColor,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  AuthButton(
                    buttonText: 'Sign up',
                    fct: () {
                      _submitFormOnRegister();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                          text: 'Already a user?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Sign in',
                                style: const TextStyle(
                                    color: tabColor, fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacementNamed(
                                        context, StoreLoginScreen.routeName);
                                  }),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
