import 'dart:convert';

import 'package:bluespace/net/service_method.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:http_parser/http_parser.dart';
import 'action.dart';
import 'state.dart';
import 'package:bluespace/models/account_info.dart';
import 'package:city_pickers/city_pickers.dart';

Effect<PersonalSettingState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalSettingState>>{
    PersonalSettingAction.action: _onAction,
    PersonalSettingAction.pickImg: _onPickImg,
    PersonalSettingAction.submit: _onSubmit,
    PersonalSettingAction.pickLocation: _onPickLocation,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<PersonalSettingState> ctx) {}
void _onPickLocation(Action action, Context<PersonalSettingState> ctx) async {
  Result result = await CityPickers.showCityPicker(
    context: ctx.context,
  );
  String provinceName = result?.provinceName ?? '';
  String cityName = result?.cityName ?? '';
  String areaName = result?.areaName ?? '';
  ctx.dispatch(PersonalSettingActionCreator.setContent(
      'location', provinceName + cityName + areaName));
}

void _onInit(Action action, Context<PersonalSettingState> ctx) {
  ctx.state.nicknamController = new TextEditingController();
  ctx.state.personalShowController = new TextEditingController();
}

void _onPickImg(Action action, Context<PersonalSettingState> ctx) async {
  List<Asset> resultList = [];
  switch (action.payload) {
    case 'profile':
      resultList = await MultiImagePicker.pickImages(
        //最多选择几张照片
        maxImages: 1,
        //是否可以拍照
        enableCamera: true,
        selectedAssets: ctx.state.profiles,
        materialOptions: MaterialOptions(
            startInAllView: true,
            allViewTitle: '所有照片',
            actionBarColor: '#2196F3',
            //未选择图片时提示
            textOnNothingSelected: '没有选择照片',
            //选择图片超过限制弹出提示
            selectionLimitReachedText: "最多选择1张照片"),
      );
      if (resultList.length >= 1) {
        ctx.dispatch(
            PersonalSettingActionCreator.setImg(action.payload, resultList[0]));
      }
      break;
    case 'backgroundImg':
      resultList = await MultiImagePicker.pickImages(
        //最多选择几张照片
        maxImages: 1,
        //是否可以拍照
        enableCamera: true,
        selectedAssets: ctx.state.backgroundImgs,
        materialOptions: MaterialOptions(
            startInAllView: true,
            allViewTitle: '所有照片',
            actionBarColor: '#2196F3',
            //未选择图片时提示
            textOnNothingSelected: '没有选择照片',
            //选择图片超过限制弹出提示
            selectionLimitReachedText: "最多选择1张照片"),
      );
      if (resultList.length >= 1) {
        ctx.dispatch(
            PersonalSettingActionCreator.setImg(action.payload, resultList[0]));
      }
      break;
    default:
  }
}

void _onSubmit(Action action, Context<PersonalSettingState> ctx) async {
  AccountInfo accountInfo = ctx.state.accountInfo;
  if (ctx.state.nickname != '') {
    var bgImg = await getImg(ctx.state.backgroundImg);
    var profileImg = await getImg(ctx.state.profile);
    FormData formData = new FormData.fromMap({
      'uid': accountInfo?.uid,
      'avatarUrl': accountInfo?.avatar,
      'avatar': profileImg,
      'bgimgUrl': accountInfo?.bgimg,
      'bgimg': bgImg,
      'nickname': ctx.state.nickname,
      'gender': ctx.state.gender,
      'introduction': ctx.state.personalShow,
      'city': ctx.state.location
    });
    var data = await DioUtil.request('setting', formData: formData);
    data = json.decode(data.toString());
    if (data['code'] == 200) {
      Fluttertoast.showToast(msg: data['msg'] ?? '编辑成功!');
    } else {
      Fluttertoast.showToast(msg: data['msg'] ?? '编辑失败!');
    }
  } else {
    Fluttertoast.showToast(msg: '昵称不能为空');
  }
}

Future getImg(Asset oldImg) async {
  if (oldImg != null) {
    //将图片转为二进制数据
    int quality = 100;
    if (oldImg.originalWidth > 1024) {
      quality = 50;
    } else if (oldImg.originalWidth > 512) {
      quality = 60;
    } else if (oldImg.originalWidth > 256) {
      quality = 70;
    }
    ByteData byteData = await oldImg.getByteData(quality: quality);
    List<int> imageData = byteData.buffer.asUint8List();
    MultipartFile multipartFile = new MultipartFile.fromBytes(
      imageData,
      //这个字段要有，否则后端接收为null
      filename: oldImg.name,
      //请求contentType，设置一下，不设置的话默认的是application/octet/stream，后台可以接收到数据，但上传后是.octet-stream文件
      contentType: MediaType("image", "jpg"),
    );
    return multipartFile;
  } else {
    return null;
  }
}
