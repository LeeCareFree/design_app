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
    MineAction.navigatorPush: _navigatorPush,
    MineAction.login: _onLogin,
  });
}

void _onAction(Action action, Context<MineState> ctx) {}

Future _navigatorPush(Action action, Context<MineState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  await Navigator.of(ctx.context).pushNamed(routerName, arguments: data);
}

Future _onLogin(Action action, Context<MineState> ctx) async {
  print('112');
  var r = (await Navigator.of(ctx.context).pushNamed('loginPage')) as Map;
  if (r == null) return;
  if (r['s'] == true) {
    print('112${r['name']}');
    String name = r['name'];
    String avatar = ctx.state.user?.avatar;
    String uid = ctx.state.user?.uid;
    ctx.dispatch(MineActionCreator.onInit(name, avatar, uid));
  }
}

Future _onInit(Action action, Context<MineState> ctx) async {
  if (ctx.state.animationController == null) {
    final Object ticker = ctx.stfState;
    ctx.state.animationController = AnimationController(
        vsync: ticker, duration: Duration(milliseconds: 1000));
  }
  String name = ctx.state.user?.username;
  String avatar = ctx.state.user?.avatar;
  String uid = ctx.state.user?.uid;
  ctx.dispatch(MineActionCreator.onInit(name, avatar, uid));
}

void _onBuild(Action action, Context<MineState> ctx) {
  ctx.state.animationController.forward();
}

void _onDispose(Action action, Context<MineState> ctx) {
  ctx.state.animationController.dispose();
}
