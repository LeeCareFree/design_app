import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<MineState> buildEffect() {
  return combineEffects(<Object, Effect<MineState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose,
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
    ctx.dispatch(MineActionCreator.onInit(name, avatar));
  }
}

Future _onInit(Action action, Context<MineState> ctx) async {
  print('111${ctx.state.userInfo}');
  if (ctx.state.animationController == null) {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
  }
  String name = ctx.state.userInfo?.username;
  String avatar = 'assets/images/avatar.png';
  ctx.dispatch(MineActionCreator.onInit(name, avatar));
}

void _onBuild(Action action, Context<MineState> ctx) {
  ctx.state.animationController.forward();
}

void _onDispose(Action action, Context<MineState> ctx) {
  ctx.state.animationController.dispose();
}
