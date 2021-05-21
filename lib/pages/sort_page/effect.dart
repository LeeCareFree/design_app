import 'dart:convert';

import 'package:bluespace/components/drapdown.dart';
import 'package:bluespace/models/designer_list.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'action.dart';
import 'state.dart';

Effect<SortState> buildEffect() {
  return combineEffects(<Object, Effect<SortState>>{
    SortAction.action: _onAction,
    SortAction.tapHead: _onTapHead,
    SortAction.getDesignerList: _onGetDesignerList,
    SortAction.conditionalSearch: _onConditionalSearch,
    Lifecycle.initState: _onInit
  });
}

void _onAction(Action action, Context<SortState> ctx) {}
void _onTapHead(Action action, Context<SortState> ctx) {}

void _onInit(Action action, Context<SortState> ctx) {
  ctx.state.refreshController = RefreshController();
  ctx.dispatch(SortActionCreator.getDesignerList());
}

void _onConditionalSearch(Action action, Context<SortState> ctx) async {
  var designfee, stylearr, service;
  switch (action.payload[0]) {
    case 'designfee':
      designfee = action.payload[1];
      break;
    case 'stylearr':
      stylearr = action.payload[1];
      break;
    case 'service':
      service = action.payload[1];
  }
  var result = await DioUtil.request('getDesignerList', formData: {
    'page': 1,
    'size': 10,
    'designfee': designfee,
    'stylearr': stylearr,
    'service': service,
  });
  result = json.decode(result.toString());
  if (result['code'] == 200) {
    DesignerList designerList = DesignerList.fromJson(result['data']);
    ctx.dispatch(SortActionCreator.initDesignerList(designerList));
    ctx.state.refreshController.refreshCompleted();
  } else {
    Fluttertoast.showToast(msg: result['msg'] ?? '获取设计师列表失败！');
  }
}

void _onGetDesignerList(Action action, Context<SortState> ctx) async {
  var result = await DioUtil.request('getDesignerList',
      formData: {'page': 1, 'size': 10});
  result = json.decode(result.toString());
  if (result['code'] == 200) {
    DesignerList designerList = DesignerList.fromJson(result['data']);
    ctx.dispatch(SortActionCreator.initDesignerList(designerList));
    ctx.state.refreshController.refreshCompleted();
  } else {
    Fluttertoast.showToast(msg: result['msg'] ?? '获取设计师列表失败！');
  }
}
