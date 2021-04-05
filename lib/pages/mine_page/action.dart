import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineAction {
  action,
  hideTip,
  showTip,
  navigatorPush,
  login,
  init,
  refreshPage,
  initAccountInfo
}

class MineActionCreator {
  static Action onAction() {
    return const Action(MineAction.action);
  }

  static Action refreshPage() {
    return const Action(MineAction.refreshPage);
  }

  static Action initAccountInfo(AccountInfo accountInfo) {
    return Action(MineAction.initAccountInfo, payload: accountInfo);
  }

  static Action showTip(String tip) {
    return Action(MineAction.showTip, payload: tip);
  }

  static Action hideTip() {
    return const Action(MineAction.hideTip);
  }

  static Action navigatorPush(String routerName, {Object arguments}) {
    return Action(MineAction.navigatorPush, payload: [routerName, arguments]);
  }

  static Action onLogin() {
    return Action(MineAction.login);
  }

  static Action onInit(String name, String avatar, String uid) {
    return Action(MineAction.init, payload: [name, avatar, uid]);
  }
}
