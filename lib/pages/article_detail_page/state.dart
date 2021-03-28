import 'dart:math';

import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/models/decorate_article.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {
  String avatar;
  String aid;
  String uid;
  int commentLikeCount;
  bool isLoading;
  ArticleDetail articleInfo;
  FocusNode commentFocusNode;
  TextEditingController commentTextController;
  bool isLike;
  bool isColl;
  String articleType;
  DecorateArticle decorateArticle;
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
      ..decorateArticle = decorateArticle
      ..commentTextController = commentTextController;
  }
}

ArticleDetailState initState(Map<String, dynamic> args) {
  ArticleDetailState state = new ArticleDetailState();
  state.aid = args['aid'];
  state.articleType = args['articleType'] ?? '2';
  state.commentLikeCount = 0;
  state.isLoading = true;
  state.isLike = false;
  state.isColl = false;
  return state;
}
