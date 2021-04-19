import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/pages/video_page/component/videoListController.dart';
import 'package:bluespace/pages/video_page/component/videoScaffold.dart';
import 'package:bluespace/pages/video_page/video.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class VideoState implements Cloneable<VideoState> {
  // List<String> videoList;
  List<UserVideo> videoList = [];
  PageController pageController;
  VideoListController videoListController;
  TikTokScaffoldController tkController;
  TextEditingController commentTextController;
  int commentLikeCount;
  bool isLike = false;
  bool isColl = false;
  bool isFollow = false;
  ArticleInfo articleInfo;
  FocusNode commentFocusNode;
  @override
  VideoState clone() {
    return VideoState()
      ..isLike = isLike
      ..isColl = isColl
      ..commentLikeCount = commentLikeCount
      ..articleInfo = articleInfo
      ..commentFocusNode = commentFocusNode
      ..tkController = tkController
      ..pageController = pageController
      ..videoList = videoList
      ..videoListController = videoListController;
  }
}

VideoState initState(Map<String, dynamic> args) {
  return VideoState();
}
