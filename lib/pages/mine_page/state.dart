import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/mine_page/mine_list_component/state.dart';
import 'package:bluespace/pages/mine_page/order_component/state.dart';
import 'package:bluespace/pages/mine_page/user_info_component/state.dart';
import 'package:bluespace/utils/overlay_entry_manage.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MineState implements Cloneable<MineState> {
  GlobalKey<ScaffoldState> scafoldState =
      GlobalKey<ScaffoldState>(debugLabel: 'mineScafold');
  UserInfo user;
  String name;
  String avatar;
  String uid;
  UserInfoState userInfoState;
  OrderComponentState orderState;
  MineListState mineListState;
  AnimationController animationController;
  AccountInfo accountInfo;
  @override
  MineState clone() {
    return MineState()
      ..accountInfo = accountInfo
      ..user = user
      ..name = name
      ..avatar = avatar
      ..uid = uid
      ..themeColor = themeColor
      ..animationController = animationController
      ..scafoldState = scafoldState
      ..userInfoState = userInfoState
      ..orderState = orderState
      ..mineListState = mineListState;
  }

  @override
  Color themeColor;
}

MineState initState(Map<String, dynamic> args) {
  MineState state = MineState();
  // state.selectedTabBarIndex = 0;
  // state.showTip = true;
  state.userInfoState = UserInfoState()
    ..overlayStateKey = GlobalKey<OverlayEntryManageState>();
  state.orderState = OrderComponentState();
  state.mineListState = MineListState();
  // state.settingsState = SettingsState()
  //   ..appLanguage = Item.fromParams(name: "System Default")
  //   ..adultContent = false
  //   ..enableNotifications = true;
  // state.name = '';
  state.avatar = '';
  return state;
}
