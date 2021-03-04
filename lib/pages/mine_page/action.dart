import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineAction { action, navigatorPush, login, init }

class MineActionCreator {
  static Action onAction() {
    return const Action(MineAction.action);
  }

  static Action navigatorPush(String routerName, {Object arguments}) {
    return Action(MineAction.navigatorPush, payload: [routerName, arguments]);
  }

  static Action onLogin() {
    return Action(MineAction.login);
  }

  static Action onInit(String name, String avatar) {
    return Action(MineAction.init, payload: [name, avatar]);
  }
}
