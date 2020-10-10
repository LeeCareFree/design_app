/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:38
 * @LastEditTime: 2020-10-10 11:10:32
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\effect.dart
 */
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<MineState> buildEffect() {
  return combineEffects(<Object, Effect<MineState>>{
    MineAction.action: _onAction,
    MineAction.login: _onLogin,
    MineAction.navigatorPush: _navigatorPush,
  });
}

void _onAction(Action action, Context<MineState> ctx) {}

Future _navigatorPush(Action action, Context<MineState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
}

Future _onLogin(Action action, Context<MineState> ctx) async {
  var r = (await Navigator.of(ctx.context).pushNamed('loginPage')) as Map;
  if (r == null) return;
  if (r['s'] == true) {
    String name = r['name'];
    String avatar = 'assets/images/avatar.png';
    bool isLogin = false;
    ctx.dispatch(MineActionCreator.onInit(name, avatar, isLogin));
  }
}

Future _onInit(Action action, Context<MineState> ctx) async {
  if (ctx.state.animationController == null) {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
  }
  String name = 'lyc';
  String avatar = 'assets/images/avatar.png';
  bool islogin = false;
  ctx.dispatch(MineActionCreator.onInit(name, avatar, islogin));
}
