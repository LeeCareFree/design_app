import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PersonalState implements Cloneable<PersonalState> {
  String bgPic;
  AnimationController animationController;
  ScrollController scrollController;
  @override
  PersonalState clone() {
    return PersonalState()
      ..bgPic = bgPic
      ..animationController = animationController
      ..scrollController = scrollController;
  }
}

PersonalState initState(Map<String, dynamic> args) {
  return PersonalState();
}
