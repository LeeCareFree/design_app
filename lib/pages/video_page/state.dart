import 'dart:async';

import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/models/article_list_data.dart';
import 'package:chewie/chewie.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoState implements Cloneable<VideoState> {
  // List<String> videoList;
  List<ArticleInfo> videoList = [];
  PageController pageController;
  TextEditingController commentTextController;
  int commentLikeCount;
  bool isLike = false;
  bool isColl = false;
  bool isFollow = false;
  bool isLoading;
  bool isShowControl = false;
  bool isFull = false;
  double playControlOpacity = 1;
  Duration position = Duration(seconds: 0);
  Timer timer;
  ArticleInfo articleInfo;
  FocusNode commentFocusNode;
  VideoPlayerController videoPlayerController;
  FijkPlayer player;
  ChewieController chewieController;
  Widget playerWidget;
  String avatar;
  String aid;
  String uid;
  @override
  VideoState clone() {
    return VideoState()
      ..player = player
      ..chewieController = chewieController
      ..position = position
      ..isFull = isFull
      ..timer = timer
      ..playControlOpacity = playControlOpacity
      ..isShowControl = isShowControl
      ..aid = aid
      ..uid = uid
      ..avatar = avatar
      ..isLike = isLike
      ..isColl = isColl
      ..isLoading = isLoading
      ..commentLikeCount = commentLikeCount
      ..articleInfo = articleInfo
      ..commentFocusNode = commentFocusNode
      ..commentTextController = commentTextController
      ..pageController = pageController
      ..videoList = videoList
      ..videoPlayerController = videoPlayerController
      ..playerWidget = playerWidget;
  }
}

VideoState initState(Map<String, dynamic> args) {
  VideoState state = VideoState();
  state.aid = args['aid'];
  state.isLoading = true;
  state.isLike = false;
  state.isColl = false;
  return state;
}
