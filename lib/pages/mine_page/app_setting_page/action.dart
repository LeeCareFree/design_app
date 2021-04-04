import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AppSettingAction { action, logout }

class AppSettingActionCreator {
  static Action onAction() {
    return const Action(AppSettingAction.action);
  }

  static Action logout() {
    return const Action(AppSettingAction.logout);
  }
}
