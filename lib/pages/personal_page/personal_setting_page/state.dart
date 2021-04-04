import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PersonalSettingState implements Cloneable<PersonalSettingState> {
  Asset backgroundImg;
  List<Asset> backgroundImgs = [];
  Asset profile;
  List<Asset> profiles = [];
  String nickname;
  String personalShow;
  int gender;
  String location;
  TextEditingController nicknamController;
  TextEditingController personalShowController;
  AccountInfo accountInfo;
  String oldProfile;
  String oldBackgroundImg;
  @override
  PersonalSettingState clone() {
    return PersonalSettingState()
      ..oldProfile = oldProfile
      ..accountInfo = accountInfo
      ..nicknamController = nicknamController
      ..personalShowController = personalShowController
      ..backgroundImg = backgroundImg
      ..backgroundImgs = backgroundImgs
      ..oldBackgroundImg = oldBackgroundImg
      ..profile = profile
      ..profiles = profiles
      ..nickname = nickname
      ..personalShow = personalShow
      ..gender = gender
      ..location = location;
  }
}

PersonalSettingState initState(Map<String, dynamic> args) {
  AccountInfo accountInfo = args['accountInfo'];
  return PersonalSettingState()
    ..accountInfo = args['accountInfo']
    ..nickname = accountInfo.nickname
    ..oldProfile = accountInfo.avatar
    ..personalShow = accountInfo.introduction
    ..gender = accountInfo.gender
    ..location = accountInfo.city
    ..oldBackgroundImg = accountInfo.bgimg;
}
