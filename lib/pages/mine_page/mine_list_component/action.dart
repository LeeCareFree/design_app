import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MineListAction { action, toArticlePage }

class MineListActionCreator {
  static Action onAction() {
    return const Action(MineListAction.action);
  }

  static Action toArticlePage() {
    return const Action(MineListAction.toArticlePage);
  }
}
