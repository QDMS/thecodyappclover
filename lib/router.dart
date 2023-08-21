import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/widgets/error.dart';
import 'package:thecodyapp/chatApp/features/auth/screens/chat_login_screen.dart';
import 'package:thecodyapp/chatApp/features/auth/screens/otp_screen.dart';
import 'package:thecodyapp/chatApp/features/auth/screens/user_information_screen.dart';
import 'package:thecodyapp/chatApp/features/group/screens/create_group_screen.dart';
import 'package:thecodyapp/chatApp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:thecodyapp/chatApp/features/chat/screens/mobile_chat_screen.dart';
import 'package:thecodyapp/chatApp/features/status/screens/confirm_status_screen.dart';
import 'package:thecodyapp/chatApp/features/status/screens/status_screen.dart';
import 'package:thecodyapp/chatApp/models/status_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatLoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const ChatLoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(
          verificationId: verificationId,
        ),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SelectContactsScreen(),
      );
    case MobileChatScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final isGroupChat = arguments['isGroupChat'];
      final profilePic = arguments['profilePic'];
      return MaterialPageRoute(
        builder: (context) => MobileChatScreen(
          name: name,
          uid: uid,
          profilePic: profilePic,
           isGroupChat: isGroupChat,
        ),
      );
    case ConfirmStatusScreen.routeName:
      final file = settings.arguments as File;
      return MaterialPageRoute(
        builder: (context) => ConfirmStatusScreen(
          file: file,
        ),
      );
    case StatusScreen.routeName:
      final status = settings.arguments as Status;
      return MaterialPageRoute(
        builder: (context) => StatusScreen(
          status: status,
        ),
      );
    case CreateGroupScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const CreateGroupScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: ErrorScreen(error: 'This page doesn\'t exist'),
        ),
      );
  }
}