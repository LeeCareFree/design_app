import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';

enum GlobalAction {
  action,
  setUser,
  changeThemeColor,
  updateUserInfo,
  setUserMember
}

class GlobalActionCreator {
  static Action onAction() {
    return const Action(GlobalAction.action);
  }

  static Action setUser(UserInfo userInfo) {
    return Action(GlobalAction.setUser, payload: userInfo);
  }

  static Action onChangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }
}
