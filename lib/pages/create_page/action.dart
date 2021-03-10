import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CreateAction { action, onShowImgClicked, onInit }

class CreateActionCreator {
  static Action onAction() {
    return const Action(CreateAction.action);
  }

  static Action onInit() {
    return Action(CreateAction.onInit);
  }

  static Action onShowImgClicked(String selectedVal) {
    return Action(CreateAction.onShowImgClicked, payload: selectedVal);
  }
}
