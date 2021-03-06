import 'dart:convert';

import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/models/designer_info.dart';
import 'package:bluespace/models/myhome_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<PersonalState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalState>>{
    PersonalAction.action: _onAction,
    PersonalAction.getAccountInfo: _onGetAccountInfo,
    PersonalAction.getDetailInfo: _onGetDetailInfo,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    PersonalAction.follow: _onFollow,
    PersonalAction.getArticleList: _onGetArticleList,
    PersonalAction.back: _onBack,
    PersonalAction.navigatorPush: _navigatorPush,
    PersonalAction.toChangeMyhomeInfo: _toChangeMyhomeInfo,
    PersonalAction.goArticleDetail: _goArticleDetail
  });
}

void _onAction(Action action, Context<PersonalState> ctx) {}

void _goArticleDetail(Action action, Context<PersonalState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  var r = await Navigator.of(ctx.context).pushNamed(routerName, arguments: data)
      as Map;
  if (r == null) return null;
  ctx.dispatch(PersonalActionCreator.updateDelArticle(r['delAid']));
}

void _onBack(Action action, Context<PersonalState> ctx) {
  Navigator.of(ctx.context).pop({'accountInfo': ctx.state.accountInfo});
}

void _navigatorPush(Action action, Context<PersonalState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  var r = await Navigator.of(ctx.context).pushNamed(routerName, arguments: data)
      as Map;
  if (r == null) return null;
  ctx.dispatch(PersonalActionCreator.initAccountInfo(r['accountInfo']));
}

void _toChangeMyhomeInfo(Action action, Context<PersonalState> ctx) async {
  String routerName = action.payload[0];
  Object data = action.payload[1];
  var r = await Navigator.of(ctx.context).pushNamed(routerName, arguments: data)
      as Map;
  if (r == null) return null;
  ctx.dispatch(PersonalActionCreator.initHomeInfo(r['myhomeInfo']));
}

Future _onGetArticleList(Action action, Context<PersonalState> ctx) async {
  String arrname = action.payload[1] == 0
      ? 'production'
      : action.payload[1] == 1
          ? 'collection'
          : action.payload[1] == 2
              ? 'like'
              : '';

  var response = await DioUtil.request('getarrlist', formData: {
    'page': action.payload[0],
    'size': 10,
    'uid': ctx.state.uid,
    'arrname': arrname
  });
  var dataJson = json.decode(response.toString());

  if (dataJson['code'] == 200) {
    ctx.dispatch(PersonalActionCreator.setLoading(false));
    List articleList = dataJson['data'];
    switch (action.payload[1]) {
      case 0:
        if (action.payload[0] == 1) {
          ctx.dispatch(PersonalActionCreator.initArticle(0, articleList));
          ctx.dispatch(PersonalActionCreator.setLoading(false));
          ctx.state.refreshController.refreshCompleted();
        } else if (dataJson['data'] != []) {
          ctx.dispatch(PersonalActionCreator.upDateArticleList(
              0, articleList, action.payload[0]));
          ctx.state.refreshController.loadComplete();
        } else {
          ctx.state.refreshController.loadNoData();
        }
        break;
      case 1:
        if (action.payload[0] == 1) {
          ctx.dispatch(PersonalActionCreator.initArticle(1, articleList));
          ctx.dispatch(PersonalActionCreator.setLoading(false));
          ctx.state.refreshController.refreshCompleted();
        } else if (dataJson['data'] != []) {
          ctx.dispatch(PersonalActionCreator.upDateArticleList(
              1, articleList, action.payload[0]));
          ctx.state.refreshController.loadComplete();
        } else {
          ctx.state.refreshController.loadNoData();
        }
        break;
      case 2:
        if (action.payload[0] == 1) {
          ctx.dispatch(PersonalActionCreator.initArticle(2, articleList));
          ctx.dispatch(PersonalActionCreator.setLoading(false));
          ctx.state.refreshController.refreshCompleted();
        } else if (dataJson['data'] != []) {
          ctx.dispatch(PersonalActionCreator.upDateArticleList(
              2, articleList, action.payload[0]));
          ctx.state.refreshController.loadComplete();
        } else {
          ctx.state.refreshController.loadNoData();
        }
        break;
      default:
    }
  } else {
    Fluttertoast.showToast(msg: dataJson['msg'] ?? '获取文章列表失败!');
  }
}

void _onFollow(Action action, Context<PersonalState> ctx) async {
  var formData = {'muid': ctx.state.mineUid, 'huid': ctx.state.uid};
  switch (action.payload) {
    case 'query':
      var res = await DioUtil.request('queryFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(PersonalActionCreator.updataIsFollow(res['data']));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '查询关注失败!');
      }
      break;
    case 'add':
      var res = await DioUtil.request('addFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(PersonalActionCreator.updataIsFollow(true));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '添加关注失败!');
      }
      break;
    case 'cancel':
      var res = await DioUtil.request('cancelFollow', formData: formData);
      res = json.decode(res.toString());
      if (res['code'] == 200) {
        ctx.dispatch(PersonalActionCreator.updataIsFollow(false));
      } else {
        Fluttertoast.showToast(msg: res['msg'] ?? '取消关注失败!');
      }
      break;
    default:
  }
}

void _onInit(Action action, Context<PersonalState> ctx) async {
  ctx.state.refreshController = new RefreshController();
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  ctx.state.tabController = TabController(length: 3, vsync: ticker);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String uid = prefs.getString('uid');
  ctx.state.mineUid = uid;
  await ctx.dispatch(PersonalActionCreator.getAccountInfo());
  print(ctx.state.accountInfo.identity);
  await ctx.dispatch(PersonalActionCreator.getDetailInfo());
  await ctx.dispatch(PersonalActionCreator.follow('query'));
  for (var i = 0; i < 3; i++) {
    String arrname = i == 0
        ? 'production'
        : i == 1
            ? 'collection'
            : i == 2
                ? 'like'
                : '';
    var response = await DioUtil.request('getarrlist', formData: {
      'page': 1,
      'size': 10,
      'uid': ctx.state.uid,
      'arrname': arrname
    });
    var dataJson = json.decode(response.toString());
    if (dataJson['code'] == 200) {
      ctx.dispatch(PersonalActionCreator.setLoading(false));
      List articleList = dataJson['data'];
      ctx.dispatch(PersonalActionCreator.initArticle(i, articleList));
    } else {
      Fluttertoast.showToast(msg: dataJson['msg'] ?? '获取文章列表失败!');
    }
  }
}

void _onGetDetailInfo(Action action, Context<PersonalState> ctx) async {
  // 获取一些用户信息
  var formData = ctx.state.accountInfo.identity != null
      ? {
          'uid': ctx.state.accountInfo?.uid,
          'identity': ctx.state.accountInfo.identity
        }
      : {
          'uid': ctx.state.accountInfo?.uid,
        };
  var res = await DioUtil.request('getDetailInfo', formData: formData);
  res = json.decode(res.toString());
  // print(res);
  if (res['code'] != 200) {
    Fluttertoast.showToast(msg: res['msg'] ?? '请稍后再试！');
  } else {
    if (ctx.state.accountInfo.identity == 'stylist') {
      DesignerInfo designerInfo = DesignerInfo.fromJson(res['data']);
      ctx.dispatch(PersonalActionCreator.initDesignerInfo(designerInfo));
      ctx.state.refreshController.refreshCompleted();
    } else {
      MyhomeInfo myhomeInfo = MyhomeInfo.fromJson(res['data']);
      ctx.dispatch(PersonalActionCreator.initHomeInfo(myhomeInfo));
      ctx.state.refreshController.refreshCompleted();
    }
  }
}

void _onGetAccountInfo(Action action, Context<PersonalState> ctx) async {
  // 获取一些用户信息
  var accountRes = await DioUtil.request('getAccountInfo',
      formData: {'uid': ctx.state.uid ?? ctx.state.mineUid});
  accountRes = json.decode(accountRes.toString());
  if (accountRes['code'] != 200) {
    Fluttertoast.showToast(msg: accountRes['msg'] ?? '请稍后再试！');
  } else {
    AccountInfo accountInfo = new AccountInfo.fromJson(accountRes['data']);
    ctx.dispatch(PersonalActionCreator.initAccountInfo(accountInfo));
    ctx.state.refreshController.refreshCompleted();
  }
}

void _onDispose(Action action, Context<PersonalState> ctx) {
  ctx.state.animationController?.dispose();
  ctx.state.scrollController?.dispose();
}
