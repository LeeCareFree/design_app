import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalState>>{
      PersonalAction.action: _onAction,
      // PersonalAction.showTitle: _onShowTitle,
      PersonalAction.initAccountInfo: _onInitAccountInfo,
      Lifecycle.initState: _onInit,
      PersonalAction.setLoading: _setLoading,
      PersonalAction.updataIsFollow: _onupdataIsFollow,
      PersonalAction.initArticle: _onInitArticle,
      PersonalAction.upDateArticleList: _onUpDateArticleList
    },
  );
}

PersonalState _onupdataIsFollow(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  newState..isFollow = action.payload;
  return newState;
}

PersonalState _onInitArticle(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
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
    default:
  }

  return newState;
}

PersonalState _onUpDateArticleList(PersonalState state, Action action) {
  List newArticleList = action.payload[1];
  final PersonalState newState = state.clone();
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
      default:
    }
  }

  return newState;
}

PersonalState _setLoading(PersonalState state, Action action) {
  final bool _loading = action.payload;
  final PersonalState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

PersonalState _onAction(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  return newState;
}

PersonalState _onInitAccountInfo(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  newState..accountInfo = action.payload;
  return newState;
}

PersonalState _onInit(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  newState
    ..isShowTitle = state.scrollController.hasClients &&
        state.scrollController.offset > Adapt.height(350);
  return newState;
}
