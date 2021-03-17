import 'package:bluespace/pages/personal_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class AppBarState implements Cloneable<AppBarState> {
  String title;
  ScrollController scrollController;
  @override
  AppBarState clone() {
    return AppBarState()
      ..title = title
      ..scrollController = scrollController;
  }
}

class AppBarConnector extends ConnOp<PersonalState, AppBarState> {
  @override
  AppBarState get(PersonalState state) {
    AppBarState substate = new AppBarState();
    // substate.title = state.detail?.title;
    substate.scrollController = state.scrollController;
    return substate;
  }
}
