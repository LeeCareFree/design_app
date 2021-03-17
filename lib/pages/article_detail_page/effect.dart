import 'dart:convert';

import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleDetailState>>{
    ArticleDetailAction.action: _onAction,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<ArticleDetailState> ctx) {}

Future _onInit(Action action, Context<ArticleDetailState> ctx) async {
  var response = await DioUtil.request('queryArticle', formData: ctx.state.aid);
  var dataJson = json.decode(response.toString());
  ArticleDetail articleDetail = new ArticleDetail.fromJson(dataJson);
  print(articleDetail.code);
}
