import 'dart:convert';
import 'dart:io';

import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/utils/toast.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<PublishState> buildEffect() {
  return combineEffects(<Object, Effect<PublishState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    PublishAction.action: _onAction,
    PublishAction.openGallery: _onOpenGallery,
    PublishAction.onPublish: _onPublish,
  });
}

void _onAction(Action action, Context<PublishState> ctx) {}

void _onInit(Action action, Context<PublishState> ctx) {
  ctx.state.titleFocusNode = FocusNode();
  ctx.state.contentFocusNode = FocusNode();
  ctx.state.titleTextController = TextEditingController();
  ctx.state.contentTextController = TextEditingController();
}

void _onOpenGallery(Action action, Context<PublishState> ctx) async {
  List<Asset> resultList = <Asset>[];
  resultList = await MultiImagePicker.pickImages(
    //最多选择几张照片
    maxImages: 9,
    //是否可以拍照
    enableCamera: true,
    selectedAssets: ctx.state.images,
    materialOptions: MaterialOptions(
        startInAllView: true,
        allViewTitle: '所有照片',
        actionBarColor: '#2196F3',
        //未选择图片时提示
        textOnNothingSelected: '没有选择照片',
        //选择图片超过限制弹出提示
        selectionLimitReachedText: "最多选择9张照片"),
  );
  if (resultList != null) {
    ctx.dispatch(PublishActionCreator.upDateImages(resultList));
  }
}

Future _onPublish(Action action, Context<PublishState> ctx) async {
  UserInfo userInfo;
  String title = ctx.state.titleTextController.text;
  String content = ctx.state.contentTextController.text;
  print(title);
  if (title == '' || content == '') {
    Toast.show('标题和描述不能为空！');
  } else {
    List<MultipartFile> imageList = new List<MultipartFile>();
    for (int i = 0; i < ctx.state.images.length; i++) {
      //将图片转为二进制数据
      ByteData byteData = await ctx.state.images[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        //这个字段要有，否则后端接收为null
        filename: ctx.state.images[i].name,
        //请求contentType，设置一下，不设置的话默认的是application/octet/stream，后台可以接收到数据，但上传后是.octet-stream文件
        contentType: MediaType("image", "jpg"),
      );
      imageList.add(multipartFile);
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid') ?? '';
    FormData formData = new FormData.fromMap({
      //后端要用multipartFiles接收参数，否则为null
      // 图片
      'type': 2,
      'uid': uid,
      'title': title,
      'detail': content,
      "files": imageList
    });
    // 使用 dio上传图片
    var data = await DioUtil.request('publish',
        formData: formData, context: ctx.context);
    data = json.decode(data.toString());
    if (data['code'] != 200) {
      Toast.show(data['msg'] ?? '请稍后再试！');
    } else {
      Toast.show('发布成功');
      Navigator.of(ctx.context).pop();
      // Navigator.of(ctx.context).pushNamed('homePage');

    }
  }
}

void _onDispose(Action action, Context<PublishState> ctx) {
  ctx.state.titleFocusNode.dispose();
  ctx.state.contentFocusNode.dispose();
}
