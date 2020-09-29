import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexAction {
  onJump,
  jump,
  initPageList,
}

class IndexActionCreator {
  static Action jump(int index) {
    return Action(IndexAction.jump, payload: index);
  }

  static Action initPageList(dynamic list) {
    return Action(IndexAction.initPageList, payload: list);
  }
}
