import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/models/article_list_data.dart';
import 'package:bluespace/pages/video_page/component/videoListController.dart';
import 'package:bluespace/pages/video_page/component/videoScaffold.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class VideoState implements Cloneable<VideoState> {
  // List<String> videoList;
  List<ArticleInfo> videoList = [];
  PageController pageController;
  VideoListController videoListController;
  TikTokScaffoldController tkController;
  TextEditingController commentTextController;
  int commentLikeCount;
  bool isLike = false;
  bool isColl = false;
  bool isFollow = false;
  bool isLoading;
  ArticleInfo articleInfo;
  FocusNode commentFocusNode;
  String avatar;
  String aid;
  String uid;
  @override
  VideoState clone() {
    return VideoState()
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
      ..tkController = tkController
      ..pageController = pageController
      ..videoList = videoList
      ..videoListController = videoListController;
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
