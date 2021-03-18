import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PersonalAction { action, showTitle }

class PersonalActionCreator {
  static Action onAction() {
    return const Action(PersonalAction.action);
  }

  static Action showTitle() {
    return const Action(PersonalAction.showTitle);
  }
}
