import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';

import 'action.dart';
import 'state.dart';

Reducer<VideoState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoState>>{
      VideoAction.action: _onAction,
      VideoAction.setLoading: _setLoading,
      VideoAction.initArticle: _onInitArticle,
      VideoAction.updataStatus: _onUpdataStatus,
      VideoAction.updateIsShowControl: _onUpdateIsShowControl,
      VideoAction.toggleFull: _onToggleFull,
      VideoAction.togglePlay: _onTogglePlay
    },
  );
}

VideoState _onTogglePlay(VideoState state, Action action) {
  final VideoState newState = state.clone();
  state.videoPlayerController.value.isPlaying
      ? newState.videoPlayerController.pause()
      : newState.videoPlayerController.play();
  if (state.timer != null) newState.timer.cancel();
  newState.timer = Timer(Duration(seconds: 3), () {
    // 延迟3s后隐藏
    newState.playControlOpacity = 0;
    Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
      newState.isShowControl = true;
    });
  }); // 操作完控件开始计时隐藏
  return newState;
}

VideoState _onToggleFull(VideoState state, Action action) {
  final VideoState newState = state.clone();
  if (state.isFull) {
    // 如果是全屏就切换竖屏
    OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
  } else {
    OrientationPlugin.forceOrientation(DeviceOrientation.landscapeRight);
  }
  if (state.timer != null) newState.timer.cancel();
  newState.timer = Timer(Duration(seconds: 3), () {
    // 延迟3s后隐藏
    newState.playControlOpacity = 0;
    Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
      newState.isShowControl = true;
    });
  }); // 操作完控件开始计时隐藏
  return newState;
}

VideoState _onUpdateIsShowControl(VideoState state, Action action) {
  final VideoState newState = state.clone();
  if (!state.isShowControl) {
    // 如果隐藏则显示
    newState.isShowControl = true;
    newState.playControlOpacity = 1;
    if (state.timer != null) newState.timer.cancel();
    newState.timer = Timer(Duration(seconds: 3), () {
      // 延迟3s后隐藏
      newState.playControlOpacity = 0;
      Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
        newState.isShowControl = true;
      });
    }); // 开始计时器，计时后隐藏
  } else {
    // 如果显示就隐藏
    if (state.timer != null) newState.timer.cancel(); // 有计时器先移除计时器
    newState.playControlOpacity = 0;
    Future.delayed(Duration(milliseconds: 300)).whenComplete(() {
      newState.isShowControl = true; // 延迟300ms(透明度动画结束)后，隐藏
    });
    print(newState.isShowControl);
  }
  return newState;
}

VideoState _onAction(VideoState state, Action action) {
  final VideoState newState = state.clone();
  return newState;
}

VideoState _setLoading(VideoState state, Action action) {
  final bool _loading = action.payload;
  final VideoState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

VideoState _onInitArticle(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.articleInfo = action.payload;
  newState.videoList = [action.payload];
  return newState;
}

VideoState _onUpdataStatus(VideoState state, Action action) {
  final VideoState newState = state.clone();
  switch (action.payload[0]) {
    case 'isLike':
      newState.isLike = action.payload[1];
      break;
    case 'isColl':
      newState.isColl = action.payload[1];
      break;
    case 'isFollow':
      newState.isFollow = action.payload[1];
      break;
    default:
  }
  return newState;
}
