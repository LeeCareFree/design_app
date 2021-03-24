import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HouseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<HouseDetailState>>{
      HouseDetailAction.action: _onAction,
      HouseDetailAction.upDateTitleImages: _onUpDateTitleImages,
    },
  );
}

HouseDetailState _onAction(HouseDetailState state, Action action) {
  final HouseDetailState newState = state.clone();
  return newState;
}

HouseDetailState _onUpDateTitleImages(HouseDetailState state, Action action) {
  final HouseDetailState newState = state.clone();
  newState.titleImage = action.payload;
  return newState;
}
