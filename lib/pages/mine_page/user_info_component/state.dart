/*
 * @Author: your name
 * @Date: 2020-10-09 18:38:25
 * @LastEditTime: 2020-10-09 18:50:05
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\header_component\state.dart
 */
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/mine_page/state.dart';
import 'package:bluespace/utils/overlay_entry_manage.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class UserInfoState implements Cloneable<UserInfoState> {
  UserInfo user;
  GlobalKey<OverlayEntryManageState> overlayStateKey;
  String name;
  String avatar;
  String uid;
  @override
  UserInfoState clone() {
    return UserInfoState()
      ..user = user
      ..avatar = avatar
      ..uid = uid
      ..overlayStateKey = overlayStateKey;
  }
}

class UserInfoConnector extends ConnOp<MineState, UserInfoState> {
  @override
  UserInfoState get(MineState state) {
    UserInfoState substate = new UserInfoState();
    substate.name = state.name;
    return substate;
  }
}
