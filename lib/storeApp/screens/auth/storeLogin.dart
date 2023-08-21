import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/features/auth/controller/auth_controller.dart';
import 'package:thecodyapp/chatApp/features/auth/screens/chat_login_screen.dart';
import 'package:thecodyapp/chatApp/screens/mobile_chat_screen_layout.dart';
import 'package:thecodyapp/storeApp/consts/constss.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/screens/fetch_screen.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeRegister.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeforgot_pass.dart';
import 'package:thecodyapp/storeApp/screens/btm_bar_screen.dart';
import 'package:thecodyapp/storeApp/screens/loading_manager.dart';
import 'package:thecodyapp/storeApp/widgets/auth_button.dart';
import 'package:thecodyapp/storeApp/widgets/google_button.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class StoreLoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/StoreLoginScreen';
  const StoreLoginScreen({super.key});

  @override
  ConsumerState<StoreLoginScreen> createState() => _StoreLoginScreenState();
}

class _StoreLoginScreenState extends ConsumerState<StoreLoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  bool _passVisibility = true;

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passwordTextController.text.trim());
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
          children: [
            Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  Constss.loginImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              duration: 4000,
              viewportFraction: 0.98,
              autoplayDelay: 8000,
              itemCount: Constss.loginImages.length,
              // control: SwiperControl(),
            ),
            Container(
              color: Colors.black.withOpacity(0.7),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 120.0,
                    ),
                    TextWidget(
                      text: 'Welcome Back To ',
                      color: Colors.white,
                      textSize: 20,
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
                      text: 'Sign In To Continue',
                      color: Colors.white,
                      textSize: 15,
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
                                borderRadius:
                                    BorderRadius.circular(30).copyWith(
                                  bottomRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: tabColor.withOpacity(.05)),
                                borderRadius:
                                    BorderRadius.circular(30).copyWith(
                                  bottomRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          //Password
                          TextFormField(
                            obscureText: _passVisibility,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              _submitFormOnLogin();
                            },
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 7) {
                                return 'Please enter a password more than 7 characters';
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
                                borderRadius:
                                    BorderRadius.circular(30).copyWith(
                                  bottomRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: tabColor.withOpacity(.05)),
                                borderRadius:
                                    BorderRadius.circular(30).copyWith(
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
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          GlobalMethods.navigateTo(
                              ctx: context,
                              routeName: StoreForgetPasswordScreen.routeName);
                        },
                        child: const Text(
                          'Forgot Password?',
                          maxLines: 1,
                          style: TextStyle(
                            color: tabColor,
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      fct: () {
                        _submitFormOnLogin();
                      },
                      buttonText: 'Login',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // // const GoogleButton(),
                    // const SizedBox(
                    //   height: 10,
                    // ),
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
                      height: 10,
                    ),
                    // AuthButton(
                    //   fct: () {},
                    //   buttonText: 'Continue As A Guest',
                    //   primary: Colors.black,
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                          children: [
                            TextSpan(
                              text: '  Sign up',
                              style: const TextStyle(
                                  color: tabColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, StoreRegisterScreen.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
