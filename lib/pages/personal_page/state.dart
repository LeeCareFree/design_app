import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/models/article_list_data.dart';
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
  bool isFollow;
  List articleList0;
  List articleList1;
  List articleList2;
  int pageIndex0 = 1;
  int pageIndex1 = 1;
  int pageIndex2 = 1;
  @override
  PersonalState clone() {
    return PersonalState()
      ..articleList0 = articleList0
      ..articleList1 = articleList1
      ..articleList2 = articleList2
      ..isFollow = isFollow
      ..refreshController = refreshController
      ..accountInfo = accountInfo
      ..bgPic = bgPic
      ..animationController = animationController
      ..tabController = tabController
      ..scrollController = scrollController
      ..isShowTitle = isShowTitle
      ..uid = uid
      ..isLoading = isLoading
      ..pageIndex0 = pageIndex0
      ..pageIndex1 = pageIndex1
      ..pageIndex2 = pageIndex2
      ..mineUid = mineUid;
  }
}

PersonalState initState(Map<String, dynamic> args) {
  PersonalState state = new PersonalState();
  state.uid = args['uid'];
  state.isLoading = true;
  return state;
}
