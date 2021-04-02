import 'package:bluespace/models/follow_fans_list.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum UserListAction {
  action,
  getList,
  setLoading,
  updateFollowList,
  updateList,
  follow,
  updataIsFollow
}

class UserListActionCreator {
  static Action onAction() {
    return const Action(UserListAction.action);
  }

  static Action follow(String type, String uid, int index) {
    return Action(UserListAction.follow, payload: [type, uid, index]);
  }

  static Action setLoading(bool loading) {
    return Action(UserListAction.setLoading, payload: loading);
  }

  static Action getList() {
    return Action(UserListAction.getList);
  }

  static Action updateList(int index, bool isFollow) {
    return Action(UserListAction.updateList, payload: [index, isFollow]);
  }
}
