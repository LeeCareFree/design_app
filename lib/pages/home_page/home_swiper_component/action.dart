import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeSwiperAction { action }

class HomeSwiperActionCreator {
  static Action onAction() {
    return const Action(HomeSwiperAction.action);
  }
}
