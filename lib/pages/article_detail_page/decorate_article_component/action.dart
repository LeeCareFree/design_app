import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DecorateArticleAction { action }

class DecorateArticleActionCreator {
  static Action onAction() {
    return const Action(DecorateArticleAction.action);
  }
}
