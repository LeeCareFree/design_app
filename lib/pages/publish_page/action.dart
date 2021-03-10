import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PublishAction { action }

class PublishActionCreator {
  static Action onAction() {
    return const Action(PublishAction.action);
  }
}
