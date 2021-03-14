import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction { action, openMenu }

class ArticleDetailActionCreator {
  static Action onAction() {
    return const Action(ArticleDetailAction.action);
  }

  static Action openMenu() {
    return Action(ArticleDetailAction.openMenu);
  }
}
