import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MyhomeSettingState> buildReducer() {
  return asReducer(
    <Object, Reducer<MyhomeSettingState>>{
      MyhomeSettingAction.action: _onAction,
      MyhomeSettingAction.setHouseProgress: _onSetHouseProgress,
      MyhomeSettingAction.setPersoanlNum: _onSetPersoanlNum,
      MyhomeSettingAction.setBeginTime: _onSetBeginTime,
      MyhomeSettingAction.setIntoTime: _onSetIntoTime,
      MyhomeSettingAction.selectHouseType: _onSelectHouseType,
      MyhomeSettingAction.selectHouseArea: _onSelectHouseArea,
      MyhomeSettingAction.updataHouseLocation: _onUpdataHouseLocation,
      MyhomeSettingAction.updataHouseBudget: _onUpdataHouseBudget,
      MyhomeSettingAction.updataHouseArea: _onUpdataHouseArea,
    },
  );
}

MyhomeSettingState _onSetHouseProgress(
    MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..progress = action.payload;
  return newState;
}

MyhomeSettingState _onSetBeginTime(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..beginTime = action.payload;
  return newState;
}

MyhomeSettingState _onSetIntoTime(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..intoTime = action.payload;
  return newState;
}

MyhomeSettingState _onSetPersoanlNum(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..personalNum = action.payload;
  return newState;
}

MyhomeSettingState _onAction(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  return newState;
}

MyhomeSettingState _onSelectHouseType(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..houseType = action.payload;
  return newState;
}

MyhomeSettingState _onSelectHouseArea(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..houseArea = action.payload;
  return newState;
}

MyhomeSettingState _onUpdataHouseLocation(
    MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..houseLocation = action.payload;
  return newState;
}

MyhomeSettingState _onUpdataHouseArea(MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..houseArea = action.payload;
  return newState;
}

MyhomeSettingState _onUpdataHouseBudget(
    MyhomeSettingState state, Action action) {
  final MyhomeSettingState newState = state.clone();
  newState..houseBudget = action.payload;
  return newState;
}
