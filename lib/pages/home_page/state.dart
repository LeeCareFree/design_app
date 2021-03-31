import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState implements Cloneable<HomeState> {
  RefreshController refreshController;
  List bannerList;
  List articleList;
  TabController tabController;
  HomeState({this.bannerList, this.articleList});
  List<String> tabs;
  int pageIndex = 1;
  @override
  HomeState clone() {
    return HomeState()
      ..tabs = tabs
      ..pageIndex = pageIndex
      ..refreshController = refreshController
      ..tabController = tabController
      ..bannerList = bannerList
      ..articleList = articleList;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..tabs = ['推荐', '全部', '图文', '视频']
    ..bannerList = new List()
    ..articleList = new List();
}
