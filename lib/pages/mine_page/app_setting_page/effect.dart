import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<AppSettingState> buildEffect() {
  return combineEffects(<Object, Effect<AppSettingState>>{
    AppSettingAction.action: _onAction,
    AppSettingAction.logout: _onLogout
  });
}

void _onAction(Action action, Context<AppSettingState> ctx) {}

void _onLogout(Action action, Context<AppSettingState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
  final token = prefs.getString('token') ?? '';
  if (token == '') {
    Navigator.of(ctx.context).pushNamedAndRemoveUntil(
      'startPage',
      ModalRoute.withName('startPage'),
      arguments: {'type': 'againLogin'},
    );
  }
}
