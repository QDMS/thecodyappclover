import 'package:flutter/material.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';

class WebProfileBar extends StatelessWidget {
  const WebProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.077,
      width: MediaQuery.of(context).size.width * 0.25,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
            color: dividerColor,
          ),
        ),
        color: webAppBarColor,
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://scontent-atl3-2.xx.fbcdn.net/v/t39.30808-6/309468212_746116600152237_7664838829684956884_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=e9hhFg_X2FQAX94eqfv&_nc_ht=scontent-atl3-2.xx&oh=00_AfDvUwKWVuGuzf11imOva7lu9T86L_i6XwpZfYmgVRSLkw&oe=649D85E8'),
            radius: 20,
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.comment_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
    );
  }
}
