import 'dart:convert';

import 'package:bluespace/models/follow_fans_list.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'action.dart';
import 'state.dart';

Effect<UserListState> buildEffect() {
  return combineEffects(<Object, Effect<UserListState>>{
    UserListAction.action: _onAction,
    Lifecycle.initState: _onInit,
    UserListAction.getList: _onGetList,
    UserListAction.follow: _onFollow,
  });
}

void _onAction(Action action, Context<UserListState> ctx) {}
void _onInit(Action action, Context<UserListState> ctx) async {
  ctx.state.refreshController = new RefreshController();
  ctx.dispatch(UserListActionCreator.getList());
}

void _onFollow(Action action, Context<UserListState> ctx) async {
  var formData = {'muid': ctx.state.uid, 'huid': action.payload[1]};
  switch (action.payload[0]) {
    case 'add':
      var res = await DioUtil.request('addFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(UserListActionCreator.updateList(action.payload[2], true));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '添加关注失败!');
      }
      break;
    case 'cancel':
      var res = await DioUtil.request('cancelFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200 || res['code'] == 409) {
        ctx.dispatch(
            UserListActionCreator.updateList(action.payload[2], false));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '取消关注失败!');
      }
      break;
    default:
  }
}

void _onGetList(Action action, Context<UserListState> ctx) async {
  switch (ctx.state.type) {
    case 'follow':
      var res = await DioUtil.request('getarrlist',
          formData: {'uid': ctx.state.uid, 'arrname': 'follow'});
      res = json.decode(res.toString());
      if (res['code'] != 200) {
        Fluttertoast.showToast(msg: res['msg'] ?? '请稍后再试！');
      } else {
        FollowFansList followFansList =
            new FollowFansList.fromJson(res['data']);
        ctx.state.followFansList = followFansList;
        ctx.state.refreshController.refreshCompleted();
        ctx.dispatch(UserListActionCreator.setLoading(false));
      }
      break;
    case 'fans':
      var res = await DioUtil.request('getarrlist',
          formData: {'uid': ctx.state.uid, 'arrname': 'fans'});
      res = json.decode(res.toString());
      if (res['code'] != 200) {
        Fluttertoast.showToast(msg: res['msg'] ?? '请稍后再试！');
      } else {
        FollowFansList followFansList =
            new FollowFansList.fromJson(res['data']);
        ctx.state.followFansList = followFansList;
        ctx.state.refreshController.refreshCompleted();
        ctx.dispatch(UserListActionCreator.setLoading(false));
      }
      break;
    default:
  }
}
