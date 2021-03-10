/*
 * @Author: your name
 * @Date: 2021-03-08 15:42:27
 * @LastEditTime: 2021-03-09 15:13:26
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\pages\home_page\effect.dart
 */

import 'dart:convert';
import 'package:fish_redux/fish_redux.dart';

import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/models/slideshow_model.dart';
import 'package:bluespace/utils/toast.dart';

import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    HomeAction.action: _onAction,
    HomeAction.getBanner: _onGetBanner
  });
}

void _onAction(Action action, Context<HomeState> ctx) {
}

Future _onGetBanner(Action action, Context<HomeState> ctx) async {
  
  var response = await DioUtil.request('slideshow');
  var dataJson = json.decode(response.toString());
  SlideShow slideShow = new SlideShow.fromJson(dataJson);
  if(slideShow.code == 200) {
    List bannerList = slideShow.data;
    // var bannerList = data['data'];
    print('+++++++++++++++${json.encode(bannerList)}');
    ctx.dispatch(HomeActionCreator.initBanner(bannerList));
  }
}
