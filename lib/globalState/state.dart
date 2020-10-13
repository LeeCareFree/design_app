import 'dart:ui';
import 'package:bluespace/models/user_info_entity.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  UserInfoEntity get userInfo;
  set userInfo(UserInfoEntity userInfo);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  UserInfoEntity userInfo;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..userInfo = userInfo;
  }
}
