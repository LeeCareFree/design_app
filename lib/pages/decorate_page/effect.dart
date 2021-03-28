import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:city_pickers/city_pickers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<DecorateState> buildEffect() {
  return combineEffects(<Object, Effect<DecorateState>>{
    DecorateAction.action: _onAction,
    DecorateAction.selectHouseLocation: _onSelectHouseLocation,
    DecorateAction.selectHouseArea: _onSelectHouseArea,
    DecorateAction.publishArticle: _onPublishArticle,
    Lifecycle.initState: _onInit
  });
}

void _onPublishArticle(Action action, Context<DecorateState> ctx) async {
  String title = ctx.state.titleController.text;
  // String content = ctx.state.contentTextController.text;
  print('111$title');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final uid = prefs.getString('uid') ?? '';
  // FormData formData = new FormData.fromMap({
  //     //后端要用multipartFiles接收参数，否则为null
  //     // 图片
  //     'type': 2,
  //     'uid': uid,
  //     'title': title,
  //     'detail': content,
  //     "files": imageList,
  //   });
}

void _onSelectHouseLocation(Action action, Context<DecorateState> ctx) async {
  Result result = await CityPickers.showCityPicker(
    context: ctx.context,
  );
  String provinceName = result?.provinceName ?? '';
  String cityName = result?.cityName ?? '';
  String areaName = result?.areaName ?? '';
  ctx.dispatch(DecorateActionCreator.updataHouseLocation(
      provinceName + cityName + areaName));
}

void _onSelectHouseArea(Action action, Context<DecorateState> ctx) async {}

void _onAction(Action action, Context<DecorateState> ctx) {}
void _onInit(Action action, Context<DecorateState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.scrollController = ScrollController();
  ctx.state.tabController = TabController(length: 3, vsync: ticker);
  ctx.state.numberController = TextEditingController();
  ctx.state.needsController = TextEditingController();
}
