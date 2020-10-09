import 'dart:ui';
import 'package:bluespace/models/user_info_entity.dart';
import 'package:fish_redux/fish_redux.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  Locale get locale;
  set locale(Locale locale);

  UserInfoEntity get user;
  set user(UserInfoEntity u);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;
  @override
  Locale locale;

  @override
  UserInfoEntity user;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = themeColor
      ..user = user;
  }
}
