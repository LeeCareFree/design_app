import 'dart:convert';

import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleDetailState>>{
    ArticleDetailAction.action: _onAction,
    ArticleDetailAction.getArticle: _onGetArticle,
    ArticleDetailAction.getUserAvatar: _onGetUserAvatar,
    ArticleDetailAction.pubilshComment: _onPubilshComment,
    ArticleDetailAction.deleteComment: _onDeleteComment,
    ArticleDetailAction.likeComment: _onLikeComment,
    ArticleDetailAction.likeHandle: _onLikeHandle,
    ArticleDetailAction.checkLikeStatus: _onCheckLikeStatus,
    ArticleDetailAction.cancelLike: _onCancelLike,
    ArticleDetailAction.collHandle: _onCollHandle,
    ArticleDetailAction.checkCollStatus: _onCheckCollStatus,
    ArticleDetailAction.cancelColl: _onCancelColl,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<ArticleDetailState> ctx) {}

void _onLikeComment(Action action, Context<ArticleDetailState> ctx) {
  ctx.dispatch(ArticleDetailActionCreator.upDatalikeCommentCount());
}

Future _onCancelLike(Action action, Context<ArticleDetailState> ctx) async {
  var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '0'};
  var response = await DioUtil.request('canceloperation', formData: fromData);
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '取消点赞成功!');
    ctx.dispatch(ArticleDetailActionCreator.updataIsLike(false));
    ctx.dispatch(ArticleDetailActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '取消点赞失败!');
  }
}

Future _onCancelColl(Action action, Context<ArticleDetailState> ctx) async {
  var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '1'};
  var response = await DioUtil.request('canceloperation', formData: fromData);
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '取消收藏成功!');
    ctx.dispatch(ArticleDetailActionCreator.updataIsColl(false));
    ctx.dispatch(ArticleDetailActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '取消收藏失败!');
  }
}

Future _onLikeHandle(Action action, Context<ArticleDetailState> ctx) async {
  var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '0'};
  var response = await DioUtil.request('addOperation', formData: fromData);
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '点赞成功!');
    ctx.dispatch(ArticleDetailActionCreator.updataIsLike(true));
    ctx.dispatch(ArticleDetailActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '点赞失败!');
  }
}

Future _onCollHandle(Action action, Context<ArticleDetailState> ctx) async {
  var fromData = {'aid': ctx.state.aid, 'uid': ctx.state.uid, 'type': '1'};
  var response = await DioUtil.request('addOperation', formData: fromData);
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '收藏成功!');
    ctx.dispatch(ArticleDetailActionCreator.updataIsColl(true));
    ctx.dispatch(ArticleDetailActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '收藏失败!');
  }
}

void _onDeleteComment(Action action, Context<ArticleDetailState> ctx) async {
  var response = await DioUtil.request('deleteComment',
      formData: {'cid': action.payload, 'aid': ctx.state.aid});
  response = json.decode(response.toString());
  if (response['code'] == 200) {
    Fluttertoast.showToast(msg: response['msg'] ?? '删除评论成功！');
    Navigator.pop(ctx.context);
    ctx.dispatch(ArticleDetailActionCreator.getArticle());
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '删除评论失败！');
  }
}

void _onPubilshComment(Action action, Context<ArticleDetailState> ctx) async {
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
      ctx.dispatch(ArticleDetailActionCreator.getArticle());
    } else {
      Fluttertoast.showToast(msg: response['msg'] ?? '评论失败！');
    }
  }
}

Future _onGetArticle(Action action, Context<ArticleDetailState> ctx) async {
  var response = await DioUtil.request('articleDetail',
      formData: {'aid': ctx.state.aid}, context: ctx.context);
  var dataJson = json.decode(response.toString());
  if (dataJson['code'] == 200) {
    ArticleDetail articleDetail = new ArticleDetail.fromJson(dataJson['data']);
    ctx.dispatch(ArticleDetailActionCreator.initArticle(articleDetail));
    ctx.dispatch(ArticleDetailActionCreator.setLoading(false));
  } else {
    Fluttertoast.showToast(msg: dataJson['msg'] ?? '获取文章失败!');
  }
}

void _onInit(Action action, Context<ArticleDetailState> ctx) async {
  ctx.state..commentFocusNode = FocusNode();
  ctx.state.commentTextController = TextEditingController();
  ctx.dispatch(ArticleDetailActionCreator.getArticle());
  ctx.dispatch(ArticleDetailActionCreator.checkLikeStatus());
  ctx.dispatch(ArticleDetailActionCreator.checkCollStatus());
  ctx.dispatch(ArticleDetailActionCreator.getUserAvatar());
}

Future _onCheckLikeStatus(
    Action action, Context<ArticleDetailState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  var fromData = {'aid': ctx.state.aid, 'uid': uid, 'type': '0'};
  var response = await DioUtil.request('queryOperation', formData: fromData);
  response = json.decode(response.toString());
  // ctx.dispatch(ArticleDetailActionCreator.setLoading(true));
  if (response['code'] == 200) {
    // ctx.dispatch(ArticleDetailActionCreator.setLoading(false));
    ctx.dispatch(ArticleDetailActionCreator.updataIsLike(response['data']));
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '查询点赞状态失败!');
  }
}

Future _onCheckCollStatus(
    Action action, Context<ArticleDetailState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  var fromData = {'aid': ctx.state.aid, 'uid': uid, 'type': '1'};
  var response = await DioUtil.request('queryOperation', formData: fromData);
  response = json.decode(response.toString());
  // ctx.dispatch(ArticleDetailActionCreator.setLoading(true));
  if (response['code'] == 200) {
    // ctx.dispatch(ArticleDetailActionCreator.setLoading(false));
    ctx.dispatch(ArticleDetailActionCreator.updataIsColl(response['data']));
  } else {
    Fluttertoast.showToast(msg: response['msg'] ?? '查询收藏状态失败!');
  }
}

void _onGetUserAvatar(Action action, Context<ArticleDetailState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final avatar = prefs.getString('avatar') ?? '';
  final uid = prefs.getString('uid') ?? '';
  ctx.state.avatar = avatar;
  ctx.state.uid = uid;
}
