import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thecodyapp/chatApp/common/providers/message_reply_provider.dart';
import 'package:thecodyapp/chatApp/common/utils/colors.dart';
import 'package:thecodyapp/chatApp/features/chat/widgets/display_text_image_gif.dart';

class MessageReplyPreview extends ConsumerStatefulWidget {
  const MessageReplyPreview({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _MessageReplyPreviewState();
}

class _MessageReplyPreviewState extends ConsumerState<MessageReplyPreview>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Alignment> _topAlignmentAnimation;
  late Animation<Alignment> _bottomAlignmentAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _topAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
      ],
    ).animate(_animController);

    _bottomAlignmentAnimation = TweenSequence<Alignment>(
      [
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomRight,
            end: Alignment.bottomLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
          weight: 1,
        ),
        TweenSequenceItem<Alignment>(
          tween: Tween<Alignment>(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
          weight: 1,
        ),
      ],
    ).animate(_animController);

    _animController.repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void cancelReply(WidgetRef ref) {
      ref.read(messageReplyProvider.notifier).update((state) => null);
    }

    final messageReply = ref.watch(messageReplyProvider);
    return AnimatedBuilder(
        animation: _animController,
        builder: (context, _) {
          return Container(
            width: 350,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: _topAlignmentAnimation.value,
                    end: _bottomAlignmentAnimation.value,
                    colors: [
                      tabColor.withOpacity(0.5),
                      tabLabelColor.withOpacity(0.5),
                    ]),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                )),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        messageReply!.isMe ? 'Me' : 'Them',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      child: const Icon(
                        Icons.close,
                        size: 16,
                      ),
                      onTap: () => cancelReply(ref),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                DisplayTextImageGIF(
                    message: messageReply.message,
                    type: messageReply.messageEnum),
              ],
            ),
          );
        });
  }
}
