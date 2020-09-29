/*
 * @Author: your name
 * @Date: 2020-09-29 16:07:32
 * @LastEditTime: 2020-09-29 18:12:53
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \my_flutter_app\lib\pages\index_page\state.dart
 */
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class IndexState implements Cloneable<IndexState> {
  int currentIndex;
  PageController pageController;
  dynamic pageList;
  @override
  IndexState clone() {
    return IndexState()
      ..currentIndex = currentIndex
      ..pageController = PageController()
      ..pageList = pageList;
  }
}

IndexState initState(Map<String, dynamic> args) {
  return IndexState().clone()
    ..currentIndex = 0
    ..pageController = PageController()
    ..pageList = [];
}

// 首页

