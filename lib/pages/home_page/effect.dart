/*
 * @Author: your name
 * @Date: 2021-03-08 15:42:27
 * @LastEditTime: 2021-03-15 11:01:08
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\pages\home_page\effect.dart
 */

import 'dart:convert';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/models/slideshow_model.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bluespace/components/searchbar_delegate.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    HomeAction.action: _onAction,
    HomeAction.getBanner: _onGetBanner,
    Lifecycle.initState: _onInit,
    HomeAction.searchBarTapped: _onSearchBarTapped,
    HomeAction.getArticleList: _onGetArticleList
  });
}

void _onAction(Action action, Context<HomeState> ctx) {}

Future _onGetBanner(Action action, Context<HomeState> ctx) async {
  var response = await DioUtil.request('slideshow');
  var dataJson = json.decode(response.toString());
  SlideShow slideShow = new SlideShow.fromJson(dataJson);
  if (slideShow.code == 200) {
    List bannerList = slideShow.data;
    ctx.dispatch(HomeActionCreator.initBanner(bannerList));
    ctx.state.refreshController.refreshCompleted();
  } else {
    Fluttertoast.showToast(msg: slideShow.msg ?? '获取轮播图失败!');
  }
}

Future _onInit(Action action, Context<HomeState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.refreshController = new RefreshController();
  ctx.state.tabController =
      TabController(length: ctx.state.tabs.length, vsync: ticker);
  ctx.dispatch(HomeActionCreator.getBanner());
  ctx.dispatch(HomeActionCreator.getArticleList('1'));
}

Future _onGetArticleList(Action action, Context<HomeState> ctx) async {
  var response = await DioUtil.request('articlelist',
      formData: {'page': 1, 'size': 10, 'way': action.payload});
  var dataJson = json.decode(response.toString());

  if (dataJson['code'] == 200) {
    List articleList = dataJson['data'];
    ctx.dispatch(HomeActionCreator.initArticle(articleList));
    ctx.state.refreshController.refreshCompleted();
  } else {
    Fluttertoast.showToast(msg: dataJson['msg'] ?? '获取文章列表失败!');
  }
}

Future _onSearchBarTapped(Action action, Context<HomeState> ctx) async {
  await showSearch(context: ctx.context, delegate: SearchBarDelegate());
}
