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
  String aid;
  @override
  ArticleDetailState clone() {
    return ArticleDetailState()
      ..username = username
      ..avatar = avatar
      ..title = title
      ..content = content
      ..time = time
      ..aid = aid;
  }
}

ArticleDetailState initState(Map<String, dynamic> args) {
  ArticleDetailState state = new ArticleDetailState();
  state.aid = args['aid'] ?? 'c5b208bc-63f8-4f2d-8b35-fcda91ecf52f';
  print(state.aid);
  return state;
}
