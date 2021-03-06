import 'dart:convert';

import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/models/article_list_data.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:chewie/chewie.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:video_player/video_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<VideoState> buildEffect() {
  return combineEffects(<Object, Effect<VideoState>>{
    VideoAction.action: _onAction,
    VideoAction.getArticle: _onGetArticle,
    VideoAction.checkStatus: _onCheckStatus,
    VideoAction.getUserAvatar: _onGetUserAvatar,
    VideoAction.follow: _onFollow,
    VideoAction.likeHandle: _onLikeHandle,
    VideoAction.collHandle: _onCollHandle,
    VideoAction.publishComment: _onPublishComment,
    VideoAction.deleteComment: _onDeleteComment,
    VideoAction.deleteArticle: _onDeleteArticle,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onDeleteArticle(Action action, Context<VideoState> ctx) async {
  var res =
      await DioUtil.request('deleteArticle', formData: {'aid': ctx.state.aid});
  res = json.decode(res.toString());
  if (res['code'] == 200) {
    Navigator.pop(ctx.context);
    Navigator.pop(ctx.context);
    Navigator.pop(ctx.context, {'delAid': ctx.state.aid});
    Fluttertoast.showToast(msg: res['msg'] ?? '文章删除成功!');
  } else {
    Fluttertoast.showToast(msg: res['msg'] ?? '删除文章失败!');
  }
}

void _onDeleteComment(Action action, Context<VideoState> ctx) async {
  var response = await DioUtil.request('deleteComment',
      formData: {'cid': action.payload, 'aid': ctx.state.aid});
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '删除评论成功！');
    Navigator.pop(ctx.context);
    ctx.dispatch(VideoActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '删除评论失败！');
  }
}

void _onPublishComment(Action action, Context<VideoState> ctx) async {
  String commentContent = ctx.state.commentTextController.text;

  if (commentContent != null && commentContent != '') {
    var formData = {
      'aid': ctx.state.articleInfo?.aid,
      'uid': ctx.state.uid,
      'content': commentContent
    };
    var response = await DioUtil.request('publishComment', formData: formData);
    response = json.decode(response.toString());
    if (response['code'] == 200) {
      Fluttertoast.showToast(msg: response['msg'] ?? '评论成功！');
      ctx.dispatch(VideoActionCreator.getArticle());
    } else {
      Fluttertoast.showToast(msg: response['msg'] ?? '评论失败！');
    }
  }
}

Future _onCollHandle(Action action, Context<VideoState> ctx) async {
  switch (action.payload) {
    case 'coll':
      var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '1'};
      var response = await DioUtil.request('addOperation', formData: fromData);
      response = json.decode(response.toString());
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['msg'] ?? '收藏成功!');
        ctx.dispatch(VideoActionCreator.updataStatus('isColl', true));
        ctx.dispatch(VideoActionCreator.getArticle());
      } else {
        Fluttertoast.showToast(msg: response['msg'] ?? '收藏失败!');
      }
      break;
    case 'coll':
      var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '1'};
      var response =
          await DioUtil.request('canceloperation', formData: fromData);
      response = json.decode(response.toString());
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['msg'] ?? '取消收藏成功!');
        ctx.dispatch(VideoActionCreator.updataStatus('isColl', false));
        ctx.dispatch(VideoActionCreator.getArticle());
      } else {
        Fluttertoast.showToast(msg: response['msg'] ?? '取消收藏失败!');
      }
      break;
    default:
  }
}

Future _onLikeHandle(Action action, Context<VideoState> ctx) async {
  switch (action.payload) {
    case 'like':
      var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '0'};
      var response = await DioUtil.request('addOperation', formData: fromData);
      response = json.decode(response.toString());
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['msg'] ?? '点赞成功!');
        ctx.dispatch(VideoActionCreator.updataStatus('isLike', true));
        ctx.dispatch(VideoActionCreator.getArticle());
      } else {
        Fluttertoast.showToast(msg: response['msg'] ?? '点赞失败!');
      }
      break;
    case 'cancel':
      var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '0'};
      var response =
          await DioUtil.request('canceloperation', formData: fromData);
      response = json.decode(response.toString());
      if (response['code'] == 200) {
        Fluttertoast.showToast(msg: response['msg'] ?? '取消点赞成功!');
        ctx.dispatch(VideoActionCreator.updataStatus('isLike', false));
        ctx.dispatch(VideoActionCreator.getArticle());
      } else {
        Fluttertoast.showToast(msg: response['msg'] ?? '取消点赞失败!');
      }
      break;
    default:
  }
}

Future _onGetArticle(Action action, Context<VideoState> ctx) async {
  var response = await DioUtil.request('articleDetail',
      formData: {'aid': ctx.state.aid}, context: ctx.context);
  var dataJson = json.decode(response.toString());
  if (dataJson['code'] == 200) {
    ArticleInfo articleDetail = new ArticleInfo.fromJson(dataJson['data']);
    ctx.dispatch(VideoActionCreator.initArticle(articleDetail));
    ctx.dispatch(VideoActionCreator.setLoading(false));
    // ctx.state.refreshController.refreshCompleted();
  } else {
    Fluttertoast.showToast(msg: dataJson['msg'] ?? '获取文章失败!');
  }
}

Future _onCheckStatus(Action action, Context<VideoState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  var fromData = {'aid': ctx.state.aid, 'uid': uid, 'type': '0'};
  var fromData1 = {'aid': ctx.state.aid, 'uid': uid, 'type': '1'};
  var response = await DioUtil.request('queryOperation', formData: fromData);
  response = json.decode(response.toString());
  // ctx.dispatch(ArticleDetailActionCreator.setLoading(true));
  if (response['code'] == 200) {
    // ctx.dispatch(ArticleDetailActionCreator.setLoading(false));
    ctx.dispatch(VideoActionCreator.updataStatus('isLike', response['data']));
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '查询点赞状态失败!');
  }
  var response1 = await DioUtil.request('queryOperation', formData: fromData1);
  response1 = json.decode(response1.toString());
  // ctx.dispatch(ArticleDetailActionCreator.setLoading(true));
  if (response['code'] == 200) {
    // ctx.dispatch(ArticleDetailActionCreator.setLoading(false));
    ctx.dispatch(VideoActionCreator.updataStatus('isColl', response1['data']));
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '查询收藏状态失败!');
  }
}

void _onFollow(Action action, Context<VideoState> ctx) async {
  var formData = {
    'muid': ctx.state.uid,
    'huid': ctx.state.articleInfo?.user?.uid
  };
  switch (action.payload) {
    case 'query':
      var res = await DioUtil.request('queryFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(VideoActionCreator.updataStatus('isFollow', res['data']));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '查询关注失败!');
      }
      break;
    case 'add':
      var res = await DioUtil.request('addFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(VideoActionCreator.updataStatus('isFollow', true));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '添加关注失败!');
      }
      break;
    case 'cancel':
      var res = await DioUtil.request('cancelFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(VideoActionCreator.updataStatus('isFollow', false));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '取消关注失败!');
      }
      break;
    default:
  }
}

void _onAction(Action action, Context<VideoState> ctx) {}

void _onGetUserAvatar(Action action, Context<VideoState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final avatar = prefs.getString('avatar') ?? '';
  final uid = prefs.getString('uid') ?? '';
  ctx.state.avatar = avatar;
  ctx.state.uid = uid;
}

void _onDispose(Action action, Context<VideoState> ctx) {
  if (ctx.state.videoPlayerController != null) {
    // 惯例。组件销毁时清理下
    ctx.state.player.release();
    ctx.state.videoPlayerController.pause();
    ctx.state.videoPlayerController.dispose();
  }
}

Future<void> initializePlayer(Action action, Context<VideoState> ctx) async {
  ctx.state.videoPlayerController = VideoPlayerController.network(
      'https://8.129.214.128:3001/upload/videos/videos_181a7f85-0a12-4e41-b5e2-d6755c499352_single.mp4');
  await Future.wait([
    ctx.state.videoPlayerController.initialize(),
  ]);
  ctx.state.chewieController = ChewieController(
    videoPlayerController: ctx.state.videoPlayerController,
    autoPlay: true,
    looping: true,
    // Try playing around with some of these other options:

    showControls: false,
    materialProgressColors: ChewieProgressColors(
      playedColor: Colors.red,
      handleColor: Colors.blue,
      backgroundColor: Colors.grey,
      bufferedColor: Colors.lightGreen,
    ),
    placeholder: Container(
      color: Colors.grey,
    ),
    autoInitialize: true,
  );
}

void _onInit(Action action, Context<VideoState> ctx) async {
  // ctx.state.isFull =
  //     MediaQuery.of(ctx.context).orientation == Orientation.landscape;
  ctx.state.videoList = [];
  ctx.state.player = FijkPlayer();
  ctx.state..commentFocusNode = FocusNode();
  ctx.state.commentTextController = TextEditingController();
  ctx.state.pageController = PageController(initialPage: 0);
  await ctx.dispatch(VideoActionCreator.getArticle());
  await ctx.dispatch(VideoActionCreator.checkStatus());
  await ctx.dispatch(VideoActionCreator.getUserAvatar());
  await ctx.dispatch(VideoActionCreator.follow('query'));
  print(ctx.state.articleInfo.videoUrl);
  ctx.state.player
      .setDataSource(ctx.state.articleInfo?.videoUrl, autoPlay: true);
  // initializePlayer(action, ctx);
  // ctx.state.videoPlayerController = VideoPlayerController.network(
  //     'http://8.129.214.128:3001/upload/videos/videos_181a7f85-0a12-4e41-b5e2-d6755c499352_single.mp4');

  // ctx.state.videoPlayerController.setLooping(true);
  // ctx.state.videoPlayerController.addListener(() {});
  // ctx.state.videoPlayerController
  //   ..initialize().then((_) {
  //     ctx.state.isLoading = false;
  //   });
  // ctx.state.videoPlayerController.play();
  // 加载资源完成时，监听播放进度，并且标记_videoInit=true加载完成
  // ctx.state.videoPlayerController.addListener(ctx.state.videoPlayerL);
}
