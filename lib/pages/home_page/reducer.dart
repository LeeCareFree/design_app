import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeState>>{
      HomeAction.action: _onAction,
      HomeAction.initBanner: _onInitBanner,
      HomeAction.initArticle: _onInitArticle,
      HomeAction.upDateArticleList: _onUpDateArticleList,
      HomeAction.updateDelArticle: _onUpdateDelArticle
    },
  );
}

HomeState _onAction(HomeState state, Action action) {
  final HomeState newState = state.clone();
  return newState;
}

HomeState _onUpdateDelArticle(HomeState state, Action action) {
  final HomeState newState = state.clone();
  for (var i = 0; i < newState.articleList0.length; i++) {
    if (newState.articleList0[i]['aid'] == action.payload) {
      newState..articleList0.remove(newState.articleList0[i]);
    }
  }
  for (var i = 0; i < newState.articleList1.length; i++) {
    if (newState.articleList1[i]['aid'] == action.payload) {
      newState..articleList1.remove(newState.articleList1[i]);
    }
  }
  for (var i = 0; i < newState.articleList2.length; i++) {
    if (newState.articleList2[i]['aid'] == action.payload) {
      newState..articleList2.remove(newState.articleList2[i]);
    }
  }
  for (var i = 0; i < newState.articleList3.length; i++) {
    if (newState.articleList3[i]['aid'] == action.payload) {
      newState..articleList3.remove(newState.articleList3[i]);
    }
  }
  return newState;
}

HomeState _onInitBanner(HomeState state, Action action) {
  final HomeState newState = state.clone();
  newState..bannerList = action.payload;
  return newState;
}

HomeState _onInitArticle(HomeState state, Action action) {
  final HomeState newState = state.clone();
  switch (action.payload[0]) {
    case 0:
      newState..articleList0 = action.payload[1];
      newState..pageIndex0 = 1;
      break;
    case 1:
      newState..articleList1 = action.payload[1];
      newState..pageIndex1 = 1;
      break;
    case 2:
      newState..articleList2 = action.payload[1];
      newState..pageIndex2 = 1;
      break;
    case 3:
      newState..articleList3 = action.payload[1];
      newState..pageIndex3 = 1;
      break;
    default:
  }
  return newState;
}

HomeState _onUpDateArticleList(HomeState state, Action action) {
  List newArticleList = action.payload[1];
  final HomeState newState = state.clone();
  if (newArticleList != null || newArticleList != []) {
    switch (action.payload[0]) {
      case 0:
        newState..articleList0 = [...state.articleList0, ...action.payload[1]];
        newState..pageIndex0 = action.payload[2];
        break;
      case 1:
        newState..articleList1 = [...state.articleList1, ...action.payload[1]];
        newState..pageIndex1 = action.payload[2];
        break;
      case 2:
        newState..articleList2 = [...state.articleList2, ...action.payload[1]];
        newState..pageIndex2 = action.payload[2];
        break;
      case 3:
        newState..articleList3 = [...state.articleList3, ...action.payload[1]];
        newState..pageIndex3 = action.payload[2];
        break;
      default:
    }
  }

  return newState;
}
