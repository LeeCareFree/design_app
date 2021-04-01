import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonalState implements Cloneable<PersonalState> {
  String bgPic;
  AnimationController animationController;
  ScrollController scrollController;
  TabController tabController;
  AccountInfo accountInfo;
  bool isShowTitle = false;
  String uid;
  String mineUid;
  bool isLoading;
  RefreshController refreshController;
  @override
  PersonalState clone() {
    return PersonalState()
      ..refreshController = refreshController
      ..accountInfo = accountInfo
      ..bgPic = bgPic
      ..animationController = animationController
      ..tabController = tabController
      ..scrollController = scrollController
      ..isShowTitle = isShowTitle
      ..uid = uid
      ..isLoading = isLoading
      ..mineUid = mineUid;
  }
}

PersonalState initState(Map<String, dynamic> args) {
  PersonalState state = new PersonalState();
  state.uid = args['uid'];
  state.isLoading = true;
  return state;
}
