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
      DecorateAction.updataHouseArea: _onUpdataHouseArea,
      DecorateAction.updateMaisonette: _onUpdateMaisonette,
      DecorateAction.updateNeeds: _onUpdateNeeds
    },
  );
}

DecorateState _onUpdateMaisonette(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..maisonette = action.payload;
  return newState;
}

DecorateState _onUpdateNeeds(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  switch (action.payload[1]) {
    case 'style':
      newState..houseStyle = action.payload[0];
      break;
    case 'duration':
      newState..duration = action.payload[0];
      break;
  }
  return newState;
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
