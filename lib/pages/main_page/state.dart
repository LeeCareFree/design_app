import 'package:bluespace/globalState/state.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class MainPageState implements GlobalBaseState, Cloneable<MainPageState> {
  int selectedIndex = 0;
  List<Widget> pages;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  MainPageState clone() {
    return MainPageState()
      ..pages = pages
      ..selectedIndex = selectedIndex
      ..scaffoldKey = scaffoldKey;
  }

  @override
  Color themeColor;
  @override
  UserInfo userInfo;
}

MainPageState initState(Map<String, dynamic> args) {
  return MainPageState()..pages = args['pages'];
}
