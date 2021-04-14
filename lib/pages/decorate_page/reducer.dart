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
      DecorateAction.updateNeeds: _onUpdateNeeds,
      DecorateAction.upDateTitleImages: _onUpDateTitleImages,
      DecorateAction.updateImgs: _onUpdateHouseTypeImgs
    },
  );
}

DecorateState _onUpdateHouseTypeImgs(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  switch (action.payload[1]) {
    case 'houseType':
      newState.houseTypeImages = action.payload[0];
      break;
    case 'parlour':
      newState.parlourImages = action.payload[0];
      break;
    case 'kitchen':
      newState.kitchenImages = action.payload[0];
      break;
    case 'masterBedroom':
      newState.masterBedroomImages = action.payload[0];
      break;
    case 'secondBedroom':
      newState.secondBedroomImages = action.payload[0];
      break;
    case 'toilet':
      newState.toiletImages = action.payload[0];
      break;
    case 'studyRoom':
      newState.studyRoomImages = action.payload[0];
      break;
    case 'balcony':
      newState.balconyImages = action.payload[0];
      break;
    case 'corridor':
      newState.corridorImages = action.payload[0];
      break;
  }
  return newState;
}

DecorateState _onUpDateTitleImages(DecorateState state, Action action) {
  final DecorateState newState = state.clone();
  newState..titleImage = action.payload;

  return newState;
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
