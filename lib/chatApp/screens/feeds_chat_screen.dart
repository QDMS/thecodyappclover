// import 'package:flutter/material.dart';
// import 'package:thecodyapp/chatApp/common/utils/colors.dart';
// import 'package:thecodyapp/chatApp/features/chat/widgets/chat_list.dart';
// import 'package:thecodyapp/chatApp/widgets/mobile_chat_appbar.dart';

// class FeedsChatScreen extends StatelessWidget {
//   const FeedsChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/backgroundImage.png'),
//               fit: BoxFit.fill),
//         ),
//         child: Column(
//           children: [
//             const MobileChatAppBar(),
//             const Expanded(
//               child: ChatList(),
//             ),
//             Container(
//               height: MediaQuery.of(context).size.height * 0.07,
//               padding: const EdgeInsets.all(10),
//               decoration: const BoxDecoration(
//                 border: Border(
//                   bottom: BorderSide(
//                     color: dividerColor,
//                   ),
//                 ),
//                 color: chatBarMessage,
//               ),
//               child: Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.emoji_emotions_rounded),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.attach_file_rounded),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(
//                         left: 10,
//                         right: 15,
//                       ),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           fillColor: searchBarColor,
//                           filled: true,
//                           hintText: 'Type A Message',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(20),
//                             borderSide: const BorderSide(
//                               width: 0,
//                               style: BorderStyle.none,
//                             ),
//                           ),
//                           contentPadding: const EdgeInsets.only(
//                             left: 20,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.mic_rounded),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
