import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PersonalAction {
  action,
  showTitle,
  getAccountInfo,
  initAccountInfo,
  setLoading,
}

class PersonalActionCreator {
  static Action onAction() {
    return const Action(PersonalAction.action);
  }

  static Action getAccountInfo() {
    return const Action(PersonalAction.getAccountInfo);
  }

  static Action setLoading(bool loading) {
    return Action(PersonalAction.setLoading, payload: loading);
  }

  static Action initAccountInfo(AccountInfo accountInfo) {
    return Action(PersonalAction.initAccountInfo, payload: accountInfo);
  }

  static Action showTitle() {
    return const Action(PersonalAction.showTitle);
  }
}
