import 'package:bluespace/pages/video_page/component/videoListController.dart';
import 'package:bluespace/pages/video_page/component/videoScaffold.dart';
import 'package:bluespace/pages/video_page/video.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<VideoState> buildEffect() {
  return combineEffects(<Object, Effect<VideoState>>{
    VideoAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<VideoState> ctx) {}
void _onInit(Action action, Context<VideoState> ctx) async {
  ctx.state.videoList = UserVideo.fetchVideo();
  ctx.state..commentFocusNode = FocusNode();
  ctx.state.commentTextController = TextEditingController();
  ctx.state.pageController = PageController(initialPage: 0);
  ctx.state.videoListController = VideoListController();
  ctx.state.tkController = TikTokScaffoldController();
  ctx.state.videoListController.init(
    ctx.state.pageController,
    ctx.state.videoList,
  );
  if (ctx.state.videoList != null) {
    ctx.state.videoListController.currentPlayer.start();
  }
}

void _onDispose(Action action, Context<VideoState> ctx) {
  ctx.state.videoListController.currentPlayer.pause();
}
