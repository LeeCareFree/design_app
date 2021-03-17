import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PersonalListAction { action }

class PersonalListActionCreator {
  static Action onAction() {
    return const Action(PersonalListAction.action);
  }
}
