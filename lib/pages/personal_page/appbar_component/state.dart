import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/pages/personal_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class AppBarState implements Cloneable<AppBarState> {
  ScrollController scrollController;
  AccountInfo accountInfo;
  String mineUid;
  @override
  AppBarState clone() {
    return AppBarState()
      ..accountInfo = accountInfo
      ..mineUid = mineUid
      ..scrollController = scrollController;
  }
}

class AppBarConnector extends ConnOp<PersonalState, AppBarState> {
  @override
  AppBarState get(PersonalState state) {
    AppBarState substate = new AppBarState();
    substate.mineUid = state.mineUid;
    substate.accountInfo = state.accountInfo;
    substate.scrollController = state.scrollController;
    return substate;
  }
  // @override
  // void set(AppBarState substate, PersonalState state) {
  //   state.accountInfo = substate.accountInfo;
  // }
}
