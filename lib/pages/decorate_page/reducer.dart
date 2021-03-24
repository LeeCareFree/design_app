import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DecorateState> buildReducer() {
  return asReducer(
    <Object, Reducer<DecorateState>>{
      DecorateAction.action: _onAction,
      DecorateAction.selectHouseType: _onSelectHouseType,
      DecorateAction.selectHouseArea: _onSelectHouseArea,
      DecorateAction.updataHouseLocation: _onUpdataHouseLocation,
      DecorateAction.updataHouseBudget: _onUpdataHouseBudget,
      DecorateAction.updataHouseArea: _onUpdataHouseArea
    },
  );
}

DecorateState _onSelectHouseType(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..houseType = action.payload;
  return newState;
}

DecorateState _onSelectHouseArea(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..houseArea = action.payload;
  return newState;
}

DecorateState _onUpdataHouseLocation(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..houseLocation = action.payload;
  return newState;
}

DecorateState _onUpdataHouseArea(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..houseArea = action.payload;
  return newState;
}

DecorateState _onUpdataHouseBudget(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..houseBudget = action.payload;
  return newState;
}

DecorateState _onAction(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  return newState;
}
