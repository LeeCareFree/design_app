import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum UserInfoAction { action }

class UserInfoActionCreator {
  static Action onAction() {
    return const Action(UserInfoAction.action);
  }
}
