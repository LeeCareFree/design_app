import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HouseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<HouseDetailState>>{
      HouseDetailAction.action: _onAction,
      HouseDetailAction.upDateTitleImages: _onUpDateTitleImages,
      HouseDetailAction.updateImgs: _onUpdateHouseTypeImgs
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

HouseDetailState _onUpdateHouseTypeImgs(HouseDetailState state, Action action) {
  final HouseDetailState newState = state.clone();
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
