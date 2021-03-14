import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailState implements Cloneable<ArticleDetailState> {
  String username;
  String avatar;
  String title;
  String content;
  String time;
  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
      ..username = username
      ..avatar = avatar
      ..title = title
      ..content = content
      ..time = time;
  }
}

ArticleDetailState initState(Map<String, dynamic> args) {
  ArticleDetailState state = new ArticleDetailState();
  // state.username =
  return state;
}
