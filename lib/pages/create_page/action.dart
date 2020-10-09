import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CreateAction { action }

class CreateActionCreator {
  static Action onAction() {
    return const Action(CreateAction.action);
  }
}
