import 'package:bluespace/models/follow_fans_list.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserListState implements Cloneable<UserListState> {
  String type = 'follow';
  FollowFansList followFansList;
  String uid;
  bool isLoading;
  bool isFollow = true;
  RefreshController refreshController;
  @override
  UserListState clone() {
    return UserListState()
      ..type = type
      ..refreshController = refreshController
      ..followFansList = followFansList
      ..isLoading = isLoading
      ..isFollow = isFollow
      ..uid = uid;
  }
}

UserListState initState(Map<String, dynamic> args) {
  return UserListState()
    ..type = args['type']
    ..uid = args['uid']
    ..isFollow = true
    ..isLoading = false;
}
