import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/common/utils/constants.dart';
import 'package:thecodyapp/chatApp/common/utils/utils.dart';
import 'package:thecodyapp/chatApp/features/auth/controller/auth_controller.dart';
import 'package:thecodyapp/chatApp/features/group/screens/create_group_screen.dart';
import 'package:thecodyapp/chatApp/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:thecodyapp/chatApp/features/chat/widgets/contacts_list.dart';
import 'package:thecodyapp/chatApp/features/status/screens/confirm_status_screen.dart';
import 'package:thecodyapp/chatApp/features/status/screens/status_contacts_screens.dart';
import 'package:thecodyapp/storeApp/screens/auth/storeLogin.dart';

class MobileChatScreenLayout extends ConsumerStatefulWidget {
  const MobileChatScreenLayout({super.key});

  @override
  ConsumerState<MobileChatScreenLayout> createState() =>
      _MobileChatScreenLayoutState();
}

class _MobileChatScreenLayoutState extends ConsumerState<MobileChatScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        ref.read(authControllerProvider).setUserState(false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0.1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Row(
            children: [
              const Text(
                'The ',
                style: TextStyle(
                    color: Color.fromRGBO(186, 12, 47, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Image.asset(
                Constants.logoPath,
                height: 50,
              ),
              const Text(
                ' Chat',
                style: TextStyle(
                  color: Color.fromRGBO(255, 215, 0, 1),
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 2),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StoreLoginScreen(),
                    ),
                  );
                },
                child: const Icon(
                  Icons.store_rounded,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Color.fromRGBO(
                  255,
                  215,
                  0,
                  1,
                ),
              ),
            ),
            PopupMenuButton(
              color: tabColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text(
                    'Create Group',
                  ),
                  onTap: () => Future(
                    () => Navigator.pushNamed(
                      context,
                      CreateGroupScreen.routeName,
                    ),
                  ),
                ),
              ],
            )
          ],
          bottom: TabBar(
            controller: tabBarController,
            indicatorColor: tabColor,
            indicatorWeight: 4,
            labelColor: tabLabelColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                text: 'CHATS',
              ),
              // StatusTab
              Tab(
                text: 'STATUS',
              ),
              Tab(
                text: 'LIVE',
              ),
              Tab(
                text: 'CALLS',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabBarController,
          children: const [
            ContactsList(),
            StatusContactsScreen(),
            Text('Live'),
            Text('Calls'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (tabBarController.index == 0) {
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            } else {
              File? pickedImage = await pickImageFromGallery(context);
              if (pickedImage != null) {
                // if (context.mounted) {
                Navigator.pushNamed(
                  context,
                  ConfirmStatusScreen.routeName,
                  arguments: pickedImage,
                );
                // }
              }
            }
          },
          backgroundColor: tabColor,
          child: const Icon(
            Icons.comment,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
