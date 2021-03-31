import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class VideoCell extends StatefulWidget {
  final VideoPlayerController controller;
  const VideoCell({this.controller});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoCell> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: widget.controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: widget.controller.value.aspectRatio,
                child: VideoPlayer(widget.controller),
              )
            : Container(),
      ),
      FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.controller.value.isPlaying
                ? widget.controller.pause()
                : widget.controller.play();
          });
        },
        child: Icon(
          widget.controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.dispose();
  }
}
