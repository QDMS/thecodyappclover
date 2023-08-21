import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/widgets/custom_button.dart';
import 'package:thecodyapp/chatApp/features/auth/screens/chat_login_screen.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/storeApp/consts/utils.dart';
import 'package:thecodyapp/storeApp/screens/fetch_screen.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeLogin.dart';
import 'package:thecodyapp/storeApp/screens/btm_bar_screen.dart';
import 'package:thecodyapp/storeApp/screens/payment/iframe.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Welcome To',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Image.asset(
                        'assets/navBarLogo.png',
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          onPressed: () async {
                            await _showStorePrivayPolicyDialog();
                          },
                          child: const Text(
                            'Tap Here to Read our Store Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: CustomButton(
                          fct: () {
                            // Navigator.pushNamed(
                            //     context, StoreLoginScreen.routeName);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StoreLoginScreen()));
                          },
                          buttonText: 'AGREE AND CONTINUE',
                          primary: tabLabelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome To The',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Image.asset(
                        'assets/TCCLogoTrans.png',
                        height: 250,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextButton(
                          onPressed: () async {
                            await _showChatPrivayPolicyDialog();
                          },
                          child: const Text(
                            'Tap Here to Read our Chat Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.75,
                        child: CustomButton(
                          fct: () {
                            Navigator.pushNamed(
                                context, ChatLoginScreen.routeName);
                          },
                          buttonText: 'AGREE AND CONTINUE',
                          primary: tabLabelColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showChatPrivayPolicyDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('The Cody Chat Privacy Policy'),
              content: const Text(
                  "Our chat app ('App') is committed to protecting the privacy and security of its users. This Privacy Policy outlines how we collect, use, disclose, and safeguard your personal information when you use our App. Please read this Privacy Policy carefully to understand our practices regarding your personal information and how we will treat it. Information We Collect 1.1. Personal Information: When you use our App, we may collect certain personal information that can be used to identify you, such as your name, email address, profile picture, and any other information you voluntarily provide. 1.2. Usage Information: We may collect information about how you use our App, including your chat history, message content, timestamps, device information, and IP address. This information helps us improve our services and provide a personalized user experience. 1.3. Cookies and Similar Technologies: We may use cookies and similar technologies to collect information about your usage patterns, preferences, and interactions with our App. These technologies help us enhance your user experience and analyze App usage. How We Use Your Information 2.1. Provide and Improve Services: We may use your personal information to provide, maintain, and improve our App, including monitoring and analyzing usage patterns, troubleshooting technical issues, and customizing your experience. 2.2. Communication: We may use your personal information to communicate with you, respond to your inquiries, and provide customer support. We may also send you promotional or informational emails, subject to your consent and applicable laws. 2.3. Personalization: We may use your information to personalize your experience within the App, including suggesting relevant content, features, or connections based on your usage patterns and preferences. 2.4. Legal Compliance: We may use and disclose your information to comply with applicable laws, regulations, legal processes, or governmental requests, as well as to enforce our terms of service or protect our rights, privacy, safety, or property. How We Share Your Information 3.1. Service Providers: We may engage trusted third-party service providers to perform various functions necessary for the operation of our App and to assist us in providing and improving our services. These service providers have access to your personal information only to perform specific tasks on our behalf and are obligated to protect your information. 3.2. Aggregated Data: We may share aggregated and anonymized information that does not personally identify you for statistical analysis, research, marketing, or other purposes. 3.3. Legal Requirements: We may disclose your personal information if required by law, court order, or governmental regulations, or if we believe in good faith that such disclosure is necessary to protect our rights, users' safety, or the public's safety.Data Security We implement reasonable security measures to protect your personal information from unauthorized access, use, alteration, or disclosure. However, please note that no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security. Children's Privacy Our App is not intended for individuals under the age of 13. We do not knowingly collect personal information from children. If you believe we have inadvertently collected information from a child, please contact us, and we will take steps to remove that information from our systems. Your Choices 6.1. Account Information: You may review, update, or delete your account information within the App settings. Please note that deleting your account will result in the loss of your data associated with that account. 6.2. Communications: You can unsubscribe from our promotional emails by following the instructions provided in the email. However, we may still send you non-promotional messages related to your account and transactions. Changes to This Privacy Policy We may update this Privacy Policy periodically to reflect changes in our practices or legal requirements. We will notify you of any material changes by posting the updated Privacy Policy within the App or by other means. Your continued use of the App after the effective date of the updated Privacy Policy constitutes your acceptance of the revised terms. Contact Us If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at [email address]. We will strive to respond to your inquiries in a timely manner. By using our App, you acknowledge that you have read and understood this Privacy Policy and agree to the collection, use, and disclosure of your personal information as described herein."),
              actions: [
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: tabLabelColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<void> _showStorePrivayPolicyDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: const Text('The Cody Chat Privacy Policy'),
              content: const Text(
                  " We are committed to protecting your privacy and ensuring the security of your personal information. Please read this Privacy Policy carefully to understand our practices regarding your personal information Information We Collect1.1 Personal Information: When you use the App, we may collect certain personal information that you provide voluntarily, such as your name, email address, postal address, and phone number. This information may be collected when you create an account, make a purchase, provide feedback or contact us for support. 1.2 Usage Information: We may also collect non-personal information about your interactions with the App, such as your device type, operating system, browser type, IP address, and App usage patterns. This information helps us improve our services and customize your experience. 1.3 Cookies and Similar Technologies: We may use cookies, web beacons, and other similar technologies to collect information about your usage of the App. This information helps us analyze trends, administer the App, track users' movements, and gather demographic information. You can manage your cookie preferences through your device or browser settings. How We Use Your Information 2.1 Provide and Improve the App: We use the information we collect to operate, maintain, and improve the App, including providing you with personalized features and content. This includes processing and fulfilling your orders, sending order confirmations and updates, and responding to your inquiries and requests. 2.2 Communication: We may use your contact information to send you important updates, promotional offers, newsletters, and other communications related to the App. You can opt-out of receiving marketing communications at any time by following the unsubscribe instructions provided in the communication. 2.3 Analytics and Research: We may analyze the data we collect to understand App usage patterns, optimize our services, and conduct research and analysis to improve user experience. 2.4 Legal Compliance and Protection: We may use your personal information to comply with applicable laws, regulations, or legal processes, and to protect our rights, privacy, safety, or property, as well as those of our users and the public. How We Share Your Information 3.1 Service Providers: We may share your personal information with trusted third-party service providers who assist us in operating the App, such as payment processors, hosting providers, and analytics services. These service providers are contractually obligated to protect your information and can only use it for the purposes specified by us. 3.2 Business Transfers: If we are involved in a merger, acquisition, or sale of all or a portion of our assets, your personal information may be transferred as part of that transaction. We will notify you of any such change and ensure that the receiving party respects the terms of this Privacy Policy. 3.3 Legal Requirements: We may disclose your personal information if required to do so by law or in response to valid requests from public authorities, such as a court order or government agency. Data Security We take reasonable measures to protect your personal information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.Children's Privacy The App is not intended for use by individuals under the age of [Insert Minimum Age]. We do not knowingly collect personal information from children under this age. If you believe we have collected information from a child, please contact us immediately, and we will take steps to remove that information from our systems. Your Choices and Rights You may review, update, or delete your personal information by accessing your account settings within the App. You also have the right to request a copy of the personal information we hold about you and to request that we correct any inaccuracies. Please contact us using the information provided at the end of this Privacy Policy to exercise your rights. Changes to this Privacy Policy We may update this Privacy Policy from time to time to reflect changes in our practices or legal requirements. We will notify you of any material changes by posting the updated Privacy Policy on the App or through other communication channels. Your continued use of the App after the effective date of the updated Privacy Policy constitutes your acceptance of the revised terms. Contact Us If you have any questions, concerns, or requests regarding this Privacy Policy or our privacy practices, please contact us at [Contact Information]. By using the App, you acknowledge that you have read, understood, and agree to be bound by this Privacy Policy."),
              actions: [
                TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: tabLabelColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
