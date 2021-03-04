import 'dart:ui';
import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);
  UserInfo get userInfo;
  set userInfo(UserInfo userInfo);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  UserInfo userInfo;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..userInfo = userInfo;
  }
}
