/*
 * @Author: your name
 * @Date: 2020-10-09 17:37:51
 * @LastEditTime: 2020-10-09 17:48:50
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\start_page\effect.dart
 */

import 'package:bluespace/router/routes.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<StartPageState> buildEffect() {
  return combineEffects(<Object, Effect<StartPageState>>{
    StartPageAction.action: _onAction,
    StartPageAction.onStart: _onStart,
    Lifecycle.build: _onBuild,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<StartPageState> ctx) {}
void _onInit(Action action, Context<StartPageState> ctx) async {
  ctx.state.pageController = PageController();
  SharedPreferences.getInstance().then((_p) async {
    final _isFirst = _p.getBool('isFirstTime') ?? true;
    if (!_isFirst)
      await _pushToMainPage(ctx.context);
    else
      ctx.dispatch(StartPageActionCreator.setIsFirst(_isFirst));
  });
}

void _onDispose(Action action, Context<StartPageState> ctx) {
  ctx.state.pageController.dispose();
}

void _onBuild(Action action, Context<StartPageState> ctx) {
  Future.delayed(Duration(milliseconds: 0), () => _pushToMainPage(ctx.context));
}
void _onStart(Action action, Context<StartPageState> ctx) async {
  SharedPreferences.getInstance().then((_p) {
    _p.setBool('isFirstTime', false);
  });
  await _pushToMainPage(ctx.context);
}

Future _pushToMainPage(BuildContext context) async {
  await Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return Routes.routes.buildPage('mainPage', {
          'pages': List<Widget>.unmodifiable([
            Routes.routes.buildPage('homePage', null),
            Routes.routes.buildPage('sortPage', null),
            Routes.routes.buildPage('createPage', null),
            Routes.routes.buildPage('likePage', null),
            Routes.routes.buildPage('minePage', null)
          ])
        });
      },
      settings: RouteSettings(name: 'mainPage')));
}
