import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:city_pickers/city_pickers.dart';
import 'action.dart';
import 'state.dart';

Effect<DecorateState> buildEffect() {
  return combineEffects(<Object, Effect<DecorateState>>{
    DecorateAction.action: _onAction,
    DecorateAction.selectHouseLocation: _onSelectHouseLocation,
    DecorateAction.selectHouseArea: _onSelectHouseArea,
    Lifecycle.initState: _onInit
  });
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
