import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:video_player/video_player.dart';

class PublishState implements Cloneable<PublishState> {
  TextEditingController titleTextController;
  TextEditingController contentTextController;
  FocusNode titleFocusNode;
  FocusNode contentFocusNode;
  String title = '';
  String content = '';
  ScrollController _imgController;
  List<Asset> images;
  File video;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  @override
  PublishState clone() {
    return PublishState()
      ..video = video
      ..videoPlayerController = videoPlayerController
      ..chewieController = chewieController
      ..title = title
      ..content = content
      ..titleFocusNode = titleFocusNode
      ..contentFocusNode = contentFocusNode
      ..titleTextController = titleTextController
      ..contentTextController = contentTextController
      .._imgController = _imgController
      ..images = images;
  }
}

PublishState initState(Map<String, dynamic> args) {
  return PublishState()
    ..video = args['video'] ?? null
    ..images = args['images'] ?? null;
}
