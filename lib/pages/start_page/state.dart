import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

class StartState implements Cloneable<StartState> {
  AnimationController animationController;
  String user = '';
  String pwd = '';
  TextEditingController userTextController;
  TextEditingController passwordTextController;
  AnimationController submitAnimationController;
  FocusNode userFocusNode;
  FocusNode pwdFocusNode;
  bool isPhoneLogin;
  PageController pageController;
  bool isLogin = true;
  String type = '';
  bool passwordVisible = false;
  @override
  StartState clone() {
    return StartState()
      ..passwordVisible = passwordVisible
      ..type = type
      ..user = user
      ..pwd = pwd
      ..pwdFocusNode = pwdFocusNode
      ..userFocusNode = userFocusNode
      ..userTextController = userTextController
      ..passwordTextController = passwordTextController
      ..submitAnimationController = submitAnimationController
      ..animationController = animationController
      ..isPhoneLogin = isPhoneLogin
      ..isLogin = isLogin
      ..pageController = pageController;
  }
}

StartState initState(Map<String, dynamic> args) {
  StartState state = new StartState();
  if (args != null) {
    state.type = args['type'] ?? '';
  }
  return state;
}
