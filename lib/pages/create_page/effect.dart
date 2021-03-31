import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:video_player/video_player.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateState> buildEffect() {
  return combineEffects(<Object, Effect<CreateState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    CreateAction.action: _onAction,
    CreateAction.onShowImgClicked: _onShowImgClicked,
    CreateAction.onShowVideoClicked: _onShowVideoClicked
  });
}

void _onAction(Action action, Context<CreateState> ctx) {}

void _onShowVideoClicked(Action action, Context<CreateState> ctx) async {
  File video;
  if (action.payload == '拍视频') {
    try {
      video = await ImagePicker.pickVideo(source: ImageSource.camera);
      if (video != null) {
        await Navigator.of(ctx.context)
            .pushNamed('publishPage', arguments: {'video': video});
      }
    } catch (e) {}
  } else if (action.payload == '选取视频') {
    try {
      video = await ImagePicker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        await Navigator.of(ctx.context)
            .pushNamed('publishPage', arguments: {'video': video});
      }
    } catch (e) {}
  }
}

void _onInit(Action action, Context<CreateState> ctx) {
  // final TickerProvider ticker = ctx.stfState as TickerProvider;
  // ctx.state.showImgAnimationController = AnimationController(
  //   vsync: ticker,
  //   duration: const Duration(milliseconds: 500),
  // );
  print('init');
  // ctx.state.imagePicker = new ImagePickerHandler(ctx.state._listener);

  // ctx.state.imagePicker.init();
}

Future _onShowImgClicked(Action action, Context<CreateState> ctx) async {
  List<Asset> resultList = [];
  if (action.payload == '拍照') {
    resultList = await MultiImagePicker.pickImages(
      maxImages: 9,
      enableCamera: true,
      selectedAssets: ctx.state.images,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
      materialOptions: MaterialOptions(
        startInAllView: true,
        actionBarColor: "#abcdef",
        actionBarTitle: "请选择",
        allViewTitle: "所有图片",
        useDetailsView: true,
        selectCircleStrokeColor: "#000000",
      ),
    );
    if (resultList.length >= 1) {
      await Navigator.of(ctx.context)
          .pushNamed('publishPage', arguments: {'images': resultList});
    }
  } else if (action.payload == '选取照片') {
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 9,
        enableCamera: true,
        selectedAssets: ctx.state.images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "请选择",
          allViewTitle: "所有图片",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
      if (resultList.length >= 1) {
        await Navigator.of(ctx.context)
            .pushNamed('publishPage', arguments: {'images': resultList});
      }
    } catch (e) {}
  }
}

void _onDispose(Action action, Context<CreateState> ctx) {
  // ctx.state.showImgAnimationController.dispose();
}
