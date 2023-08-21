import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/firebase_consts.dart';
import 'package:thecodyapp/storeApp/consts/global_methods.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeLogin.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeforgot_pass.dart';
import 'package:thecodyapp/storeApp/screens/loading_manager.dart';
import 'package:thecodyapp/storeApp/screens/orders/orders_screen.dart';
import 'package:thecodyapp/storeApp/screens/viewed_recently/viewed_recently_screen.dart';
import 'package:thecodyapp/storeApp/screens/wishlist/wishlist_screen.dart';
import 'package:thecodyapp/storeApp/widgets/text_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");
  final _phoneNumberTextController = TextEditingController();

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  String? _email;
  String? _name;
  String? _phoneNumber;
  String? _address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('storeUsers')
          .doc(_uid)
          .get();
      if (userDoc == null) {
        return;
      } else {
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        _phoneNumber = userDoc.get('phoneNumber');
        _address = userDoc.get('address');
        _addressTextController.text = userDoc.get('address');
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingManager(
        isLoading: _isLoading,
        child: Center(
          heightFactor: 1.025,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Hi, ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: _name == null ? 'User' : _name,
                          style: const TextStyle(
                            color: tabColor,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('My name is pressed');
                            },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: _email == null ? 'Email' : _email!,
                    color: Colors.white,
                    textSize: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Divider(
                    color: dividerColor,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _listTiles(
                    title: 'Shipping Address',
                    subtitle: _address,
                    icon: IconlyLight.location,
                    onPressed: () async {
                      await _showAddressDialog();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Phone Number',
                    subtitle: _phoneNumber,
                    icon: Icons.phone,
                    onPressed: () async {
                      await _showPhoneNumberChangeDialog();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Orders',
                    icon: IconlyLight.bag,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: OrdersScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Wishlist',
                    icon: IconlyLight.heart,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context, routeName: WishlistScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Viewed',
                    icon: IconlyLight.show,
                    onPressed: () {
                      GlobalMethods.navigateTo(
                          ctx: context,
                          routeName: ViewedRecentlyScreen.routeName);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Forgot Password',
                    icon: IconlyLight.lock,
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              const StoreForgetPasswordScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: user == null ? 'Login' : 'Logout',
                    icon: user == null ? IconlyLight.login : IconlyLight.logout,
                    onPressed: () {
                      if (user == null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const StoreLoginScreen(),
                          ),
                        );
                        return;
                      }
                      GlobalMethods.warningDialog(
                          title: 'Sign out',
                          subtitle: 'Do you wanna sign out?',
                          fct: () async {
                            await authInstance.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  if (mounted) {
                                    return const StoreLoginScreen();
                                  } else {
                                    return Container(); // Return an empty widget or handle the case when the widget is not mounted
                                  }
                                },
                              ),
                            );
                          },
                          context: context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print('_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('storeUsers')
                        .doc(_uid)
                        .update({
                      'address': _addressTextController.text,
                    });
                    Navigator.pop(context);
                    setState(() {
                      _address = _addressTextController.text;
                    });
                  } catch (err) {
                    GlobalMethods.errorDialog(
                        subtitle: err.toString(), context: context);
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: tabLabelColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showPhoneNumberChangeDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update'),
            content: TextField(
              // onChanged: (value) {
              //   print('_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _phoneNumberTextController,
              maxLines: 5,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: "Your Phone Number"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  String _uid = user!.uid;
                  try {
                    await FirebaseFirestore.instance
                        .collection('storeUsers')
                        .doc(_uid)
                        .update({
                      'phoneNumber': _phoneNumberTextController.text,
                    });
                    Navigator.pop(context);
                    setState(() {
                      _phoneNumber = _phoneNumberTextController.text;
                    });
                  } catch (err) {
                    GlobalMethods.errorDialog(
                        subtitle: err.toString(), context: context);
                  }
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: tabLabelColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: Colors.white,
        textSize: 24,
        isTitle: true,
      ),
      subtitle:
          TextWidget(text: (subtitle ?? ''), color: Colors.white, textSize: 18),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
