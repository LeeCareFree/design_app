import 'dart:convert';

import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<MineState> buildEffect() {
  return combineEffects(<Object, Effect<MineState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
    MineAction.refreshPage: _onRefreshPage,
    MineAction.action: _onAction,
    MineAction.navigatorPush: _navigatorPush,
    MineAction.toPersoanlPage: _onToPersoanlPage,
  });
}

void _onAction(Action action, Context<MineState> ctx) {}
void _onRefreshPage(Action action, Context<MineState> ctx) async {
  // 获取一些用户信息
  var accountRes =
      await DioUtil.request('getAccountInfo', formData: {'uid': ctx.state.uid});
  accountRes = json.decode(accountRes.toString());
  if (accountRes['code'] != 200) {
    Fluttertoast.showToast(msg: accountRes['msg'] ?? '请稍后再试！');
  } else {
    AccountInfo accountInfo = new AccountInfo.fromJson(accountRes['data']);
    ctx.dispatch(MineActionCreator.initAccountInfo(accountInfo));
    ctx.state.refreshController.refreshCompleted();
  }
}

Future _navigatorPush(Action action, Context<MineState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
}

Future _onToPersoanlPage(Action action, Context<MineState> ctx) async {
  var r = (await Navigator.of(ctx.context)
      .pushNamed('personalPage', arguments: {'uid': ctx.state.uid})) as Map;
  if (r == null) return;
  AccountInfo accountInfo = r['accountInfo'];
  ctx.dispatch(MineActionCreator.initAccountInfo(accountInfo));
}

Future _onInit(Action action, Context<MineState> ctx) async {
  ctx.state.refreshController = new RefreshController();
  if (ctx.state.animationController == null) {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String name = prefs.getString('username');
  String avatar = prefs.getString('avatar');
  String uid = prefs.getString('uid');
  ctx.dispatch(MineActionCreator.onInit(name, avatar, uid));
  // 获取一些用户信息
  var accountRes =
      await DioUtil.request('getAccountInfo', formData: {'uid': uid});
  accountRes = json.decode(accountRes.toString());
  if (accountRes['code'] != 200) {
    Fluttertoast.showToast(msg: accountRes['msg'] ?? '请稍后再试！');
  } else {
    AccountInfo accountInfo = new AccountInfo.fromJson(accountRes['data']);
    await ctx.dispatch(MineActionCreator.initAccountInfo(accountInfo));
  }
}

void _onBuild(Action action, Context<MineState> ctx) {
  ctx.state.animationController.forward();
}

void _onDispose(Action action, Context<MineState> ctx) {
  ctx.state.animationController.dispose();
}
