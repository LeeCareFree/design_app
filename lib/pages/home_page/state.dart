import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeState implements Cloneable<HomeState> {
  RefreshController refreshController;
  List bannerList;
  List articleList0;
  List articleList1;
  List articleList2;
  List articleList3;
  TabController tabController;
  List<String> tabs;
  int pageIndex0 = 1;
  int pageIndex1 = 1;
  int pageIndex2 = 1;
  int pageIndex3 = 1;
  String uid;
  String delAid;
  @override
  HomeState clone() {
    return HomeState()
      ..delAid = delAid
      ..tabs = tabs
      ..uid = uid
      ..pageIndex0 = pageIndex0
      ..pageIndex1 = pageIndex1
      ..pageIndex2 = pageIndex2
      ..pageIndex3 = pageIndex3
      ..refreshController = refreshController
      ..tabController = tabController
      ..bannerList = bannerList
      ..articleList0 = articleList0
      ..articleList1 = articleList1
      ..articleList2 = articleList2
      ..articleList3 = articleList3;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..delAid = args['delAid']
    ..tabs = ['关注', '全部', '图文', '视频']
    ..bannerList = new List()
    ..articleList0 = new List()
    ..articleList1 = new List()
    ..articleList2 = new List()
    ..articleList3 = new List();
}
