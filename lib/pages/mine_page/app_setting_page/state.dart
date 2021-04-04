import 'package:fish_redux/fish_redux.dart';

class AppSettingState implements Cloneable<AppSettingState> {

  @override
  AppSettingState clone() {
    return AppSettingState();
  }
}

AppSettingState initState(Map<String, dynamic> args) {
  return AppSettingState();
}
