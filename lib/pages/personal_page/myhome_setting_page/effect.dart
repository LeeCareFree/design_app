import 'dart:convert';

import 'package:bluespace/models/myhome_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<MyhomeSettingState> buildEffect() {
  return combineEffects(<Object, Effect<MyhomeSettingState>>{
    MyhomeSettingAction.action: _onAction,
    MyhomeSettingAction.selectHouseLocation: _onSelectHouseLocation,
    MyhomeSettingAction.submit: _onSubmit,
    MyhomeSettingAction.back: _onBack,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<MyhomeSettingState> ctx) {}
void _onBack(Action action, Context<MyhomeSettingState> ctx) {
  MyhomeInfo myhomeInfo = action.payload;
  Navigator.of(ctx.context)
      .pop({'uid': myhomeInfo?.uid, 'myhomeInfo': myhomeInfo});
}

void _onInit(Action action, Context<MyhomeSettingState> ctx) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  ctx.state.uid = sharedPreferences.getString('uid');
  ctx.state.numberController = TextEditingController();
}

void _onSubmit(Action action, Context<MyhomeSettingState> ctx) async {
  if (ctx.state.houseType != null &&
      ctx.state.houseArea != null &&
      ctx.state.houseLocation != null &&
      ctx.state.progress != null) {
    var formData = {
      "uid": ctx.state.uid,
      "city": ctx.state.houseLocation,
      "cost": ctx.state.houseBudget,
      "progress": ctx.state.progress,
      "doorModel": ctx.state.houseType,
      "area": ctx.state.houseArea,
      "populace": ctx.state.personalNum,
      "beginTime": ctx.state.beginTime,
      "checkInTime": ctx.state.intoTime,
    };
    var res = await DioUtil.request('settingMyhome', formData: formData);
    res = json.decode(res.toString());
    if (res['code'] == 200) {
      MyhomeInfo myhomeInfo = MyhomeInfo.fromJson(res['data']);
      ctx.dispatch(MyhomeSettingActionCreator.back(myhomeInfo));
    } else {
      Fluttertoast.showToast(msg: res['msg'] ?? '编辑出错！');
    }
  } else {
    Fluttertoast.showToast(msg: '请填写必填项！');
  }
}

void _onSelectHouseLocation(
    Action action, Context<MyhomeSettingState> ctx) async {
  Result result = await CityPickers.showCityPicker(
    context: ctx.context,
  );
  String provinceName = result?.provinceName ?? '';
  String cityName = result?.cityName ?? '';
  String areaName = result?.areaName ?? '';
  ctx.dispatch(MyhomeSettingActionCreator.updataHouseLocation(
      provinceName + cityName + areaName));
}
