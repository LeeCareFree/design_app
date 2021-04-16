import 'package:bluespace/models/myhome_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class MyhomeSettingState implements Cloneable<MyhomeSettingState> {
  TextEditingController numberController;
  String houseType;
  String houseArea;
  String houseLocation;
  String houseBudget;
  String progress;
  String personalNum;
  String beginTime;
  String intoTime;
  MyhomeInfo myhomeInfo;
  String uid;
  @override
  MyhomeSettingState clone() {
    return MyhomeSettingState()
      ..uid = uid
      ..myhomeInfo = myhomeInfo
      ..beginTime = beginTime
      ..intoTime = intoTime
      ..progress = progress
      ..houseType = houseType
      ..houseArea = houseArea
      ..houseLocation = houseLocation
      ..houseBudget = houseBudget
      ..personalNum = personalNum
      ..numberController = numberController;
  }
}

MyhomeSettingState initState(Map<String, dynamic> args) {
  MyhomeInfo myhomeInfo = args['homeInfo'];
  return MyhomeSettingState()
    ..myhomeInfo = myhomeInfo
    ..houseArea = myhomeInfo.area ?? ''
    ..houseType = myhomeInfo.doorModel ?? ''
    ..houseLocation = myhomeInfo.city ?? ''
    ..progress = myhomeInfo.progress ?? ""
    ..houseBudget = myhomeInfo.cost ?? ''
    ..personalNum = myhomeInfo.populace ?? ''
    ..beginTime = myhomeInfo.beginTime ?? ''
    ..intoTime = myhomeInfo.checkInTime ?? '';
}
