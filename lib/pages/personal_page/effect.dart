import 'dart:convert';

import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<PersonalState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalState>>{
    PersonalAction.action: _onAction,
    PersonalAction.getAccountInfo: _onGetAccountInfo,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<PersonalState> ctx) {}

void _onInit(Action action, Context<PersonalState> ctx) async {
  ctx.state.refreshController = new RefreshController();
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  ctx.state.tabController = TabController(length: 3, vsync: ticker);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');
  ctx.state.mineUid = uid;
  ctx.dispatch(PersonalActionCreator.getAccountInfo());
}

void _onGetAccountInfo(Action action, Context<PersonalState> ctx) async {
  // 获取一些用户信息
  var accountRes = await DioUtil.request('getAccountInfo',
      formData: {'uid': ctx.state.uid ?? ctx.state.mineUid});
  accountRes = json.decode(accountRes.toString());
  if (accountRes['code'] != 200) {
    Fluttertoast.showToast(msg: accountRes['msg'] ?? '请稍后再试！');
  } else {
    AccountInfo accountInfo = new AccountInfo.fromJson(accountRes['data']);
    ctx.dispatch(PersonalActionCreator.initAccountInfo(accountInfo));
    ctx.dispatch(PersonalActionCreator.setLoading(false));
  }
}

void _onDispose(Action action, Context<PersonalState> ctx) {
  ctx.state.animationController?.dispose();
  ctx.state.scrollController?.dispose();
}
