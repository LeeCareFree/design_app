import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SortState> buildReducer() {
  return asReducer(
    <Object, Reducer<SortState>>{
      SortAction.action: _onAction,
      SortAction.initDesignerList: _onInitDesignerList,
      SortAction.updateParams: _onUpdateParams
    },
  );
}

SortState _onInitDesignerList(SortState state, Action action) {
  final SortState newState = state.clone();
  newState.designerList = action.payload;
  return newState;
}

SortState _onUpdateParams(SortState state, Action action) {
  final SortState newState = state.clone();
  switch (action.payload[0]) {
    case 'designfee':
      newState.designfee = action.payload[1];
      break;
    case 'stylearr':
      newState.stylearr = action.payload[1];
      break;
    case 'service':
      newState.service = action.payload[1];
      break;
    default:
  }
  return newState;
}

SortState _onAction(SortState state, Action action) {
  final SortState newState = state.clone();
  return newState;
}
