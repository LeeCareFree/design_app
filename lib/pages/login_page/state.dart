/*
 * @Author: your name
 * @Date: 2020-10-10 14:15:11
 * @LastEditTime: 2020-10-14 14:02:41
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\login_page\state.dart
 */
import 'dart:ui';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class LoginPageState implements Cloneable<LoginPageState> {
  AnimationController animationController;
  String user = '';
  String pwd = '';
  TextEditingController userTextController;
  TextEditingController passwordTextController;
  AnimationController submitAnimationController;
  FocusNode userFocusNode;
  FocusNode pwdFocusNode;
  bool isPhoneLogin;
  @override
  LoginPageState clone() {
    return LoginPageState()
      ..user = user
      ..pwd = pwd
      ..pwdFocusNode = pwdFocusNode
      ..userFocusNode = userFocusNode
      ..userTextController = userTextController
      ..passwordTextController = passwordTextController
      ..submitAnimationController = submitAnimationController
      ..animationController = animationController
      ..isPhoneLogin = isPhoneLogin;
  }
  @override
  Color themeColor;
}

LoginPageState initState(Map<String, dynamic> args) {
  return LoginPageState();
}
