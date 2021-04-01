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

  static Action updataIsFollow(bool isFollow) {
    return Action(UserListAction.updataIsFollow, payload: isFollow);
  }

  static Action follow(String type, String uid) {
    return Action(UserListAction.follow, payload: [type, uid]);
  }

  static Action setLoading(bool loading) {
    return Action(UserListAction.setLoading, payload: loading);
  }

  static Action getList() {
    return Action(UserListAction.getList);
  }

  static Action updateList(FollowFansList followFansList) {
    return Action(UserListAction.updateList, payload: followFansList);
  }
}
