import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalState implements Cloneable<PersonalState> {
  String bgPic;
  AnimationController animationController;
  ScrollController scrollController;
  TabController tabController;
  bool isShowTitle = false;
  @override
  PersonalState clone() {
    return PersonalState()
      ..bgPic = bgPic
      ..animationController = animationController
      ..tabController = tabController
      ..scrollController = scrollController
      ..isShowTitle = isShowTitle;
  }
}

PersonalState initState(Map<String, dynamic> args) {
  PersonalState state = new PersonalState();
  // state.scrollController.addListener(() {});
  return state;
}
