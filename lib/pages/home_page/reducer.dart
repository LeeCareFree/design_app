import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.action: _onAction,
      HomeAction.initBanner: _onInitBanner,
      HomeAction.initArticle: _onInitArticle,
      HomeAction.upDateArticleList: _onUpDateArticleList
    },
  );
}

HomeState _onAction(HomeState state, Action action) {
  final HomeState newState = state.clone();
  return newState;
}

HomeState _onInitBanner(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState..bannerList = action.payload;
  return newState;
}

HomeState _onInitArticle(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState..articleList = action.payload;
  newState..pageIndex = 1;
  return newState;
}

HomeState _onUpDateArticleList(HomeState state, Action action) {
  List newArticleList = action.payload;
  final HomeState newState = state.clone();
  if (newArticleList != null || newArticleList != []) {
    newState..articleList = [...state.articleList, ...action.payload[0]];
    newState..pageIndex = action.payload[1];
  }

  return newState;
}
