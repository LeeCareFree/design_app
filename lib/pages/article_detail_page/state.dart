import 'dart:math';

import 'package:bluespace/models/article_detail.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
      ..avatar = avatar
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
  state.articleType = args['type'] ?? '1';
  state.commentLikeCount = 0;
  state.isLoading = true;
  state.isLike = false;
  state.isColl = false;
  return state;
}
