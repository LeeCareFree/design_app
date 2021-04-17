import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class RegisterPageState implements Cloneable<RegisterPageState> {
  String password;
  String passwordTwo;
  String name;
  bool passwordVisible = false;
  bool passwordTwoVisible = false;
  bool isDesigner = false;
  TextEditingController nameTextController;
  TextEditingController passWordTextController;
  TextEditingController passWordTwoTextController;
  FocusNode nameFocusNode;
  FocusNode pwdFocusNode;
  FocusNode pwdTwoFocusNode;
  AnimationController animationController;
  AnimationController submitAnimationController;

  @override
  RegisterPageState clone() {
    return RegisterPageState()
      ..isDesigner = isDesigner
      ..passwordTwoVisible = passwordTwoVisible
      ..passwordVisible = passwordVisible
      ..passwordTwo = passwordTwo
      ..password = password
      ..name = name
      ..animationController = animationController
      ..nameFocusNode = nameFocusNode
      ..pwdFocusNode = pwdFocusNode
      ..pwdTwoFocusNode = pwdTwoFocusNode
      ..submitAnimationController = submitAnimationController
      ..passWordTextController = passWordTextController
      ..passWordTwoTextController = passWordTwoTextController
      ..nameTextController = nameTextController;
  }
}

RegisterPageState initState(Map<String, dynamic> args) {
  return RegisterPageState();
}
