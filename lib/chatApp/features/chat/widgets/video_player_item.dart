// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerItem({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  CachedVideoPlayerController? videoPlayerController;
  bool? _isVideoPlaying;

  @override
  void initState() {
    super.initState();
    videoPlayerController = CachedVideoPlayerController.network(widget.videoUrl)
      ..initialize().then((value) {
        videoPlayerController?.setVolume(1);
        setState(() {
          _isVideoPlaying = true;
          videoPlayerController?.play();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  void _replayVideo() {
    setState(() {
      _isVideoPlaying = true;
      videoPlayerController?.seekTo(Duration.zero);
      videoPlayerController?.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = _isVideoPlaying! ? Colors.transparent : Colors.white;
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: Stack(
        children: [
          CachedVideoPlayer(videoPlayerController!),
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: _replayVideo,
              icon: Icon(
                _isVideoPlaying! ? Icons.pause_circle : Icons.play_circle,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
