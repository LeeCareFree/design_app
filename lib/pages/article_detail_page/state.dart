import 'dart:math';

import 'package:bluespace/models/article_detail.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {
  String avatar;
  String aid;
  String uid;
  int commentLikeCount;
  bool isLoading;
  ArticleInfo articleInfo;
  FocusNode commentFocusNode;
  TextEditingController commentTextController;
  bool isLike;
  bool isColl;
  String articleType;
  bool isFollow;
  RefreshController refreshController;
  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
      ..refreshController = refreshController
      ..avatar = avatar
      ..isFollow = isFollow
      ..aid = aid
      ..uid = uid
      ..isLoading = isLoading
      ..isLike = isLike
      ..isColl = isColl
      ..commentLikeCount = commentLikeCount
      ..articleInfo = articleInfo
      ..commentFocusNode = commentFocusNode
      ..articleType = articleType
      ..commentTextController = commentTextController;
  }
}

ArticleDetailState initState(Map<String, dynamic> args) {
  ArticleDetailState state = new ArticleDetailState();
  state.aid = args['aid'];
  state.articleType = args['type'];
  state.commentLikeCount = 0;
  state.isLoading = true;
  state.isLike = false;
  state.isColl = false;
  return state;
}
