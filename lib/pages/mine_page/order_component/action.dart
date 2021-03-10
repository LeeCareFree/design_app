import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum OrderComponentAction { action, navigatorPush }

class OrderComponentActionCreator {
  static Action onAction() {
    return const Action(OrderComponentAction.action);
  }

  static Action navigatorPush(String routeName, {Object arguments}) {
    return Action(OrderComponentAction.navigatorPush,
        payload: [routeName, arguments]);
  }
}
