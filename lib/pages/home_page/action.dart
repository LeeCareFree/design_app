
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeAction { action, getBanner, initBanner, searchBarTapped }

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action getBanner() {
    return Action(HomeAction.getBanner);
  }

  static Action initBanner(var list) {
    return Action(HomeAction.initBanner, payload: list);
  }

  static Action onSearchBarTapped() {
    return Action(HomeAction.searchBarTapped);
  }
}
