import 'package:bluespace/pages/decorate_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class HouseDetailState implements Cloneable<HouseDetailState> {
  TextEditingController titleController;
  TextEditingController houseTypeController;
  FocusNode titleFocusNode;
  Asset titleImage;
  List<Asset> titleImages = [];
  List<Asset> houseTypeImages = [];
  List<Asset> parlourImages = [];
  List<Asset> kitchenImages = [];
  List<Asset> masterBedroomImages = [];
  List<Asset> secondBedroomImages = [];
  List<Asset> studyRoomImages = [];
  List<Asset> toiletImages = [];
  List<Asset> balconyImages = [];
  List<Asset> corridorImages = [];
  @override
  HouseDetailState clone() {
    return HouseDetailState()
      ..houseTypeController = houseTypeController
      ..titleController = titleController
      ..titleFocusNode = titleFocusNode
      ..titleImage = titleImage
      ..titleImages = titleImages
      ..houseTypeImages = houseTypeImages
      ..parlourImages = parlourImages
      ..kitchenImages = kitchenImages
      ..masterBedroomImages = masterBedroomImages
      ..secondBedroomImages = secondBedroomImages
      ..studyRoomImages = studyRoomImages
      ..toiletImages = toiletImages
      ..balconyImages = balconyImages
      ..corridorImages = corridorImages;
  }
}

class HouseDetailConnector extends ConnOp<DecorateState, HouseDetailState> {
  @override
  HouseDetailState get(DecorateState state) {
    HouseDetailState substate = new HouseDetailState();
    substate.titleImage = state.titleImage;
    substate.balconyImages = state.balconyImages;
    substate.corridorImages = state.corridorImages;
    substate.houseTypeImages = state.houseTypeImages;
    substate.kitchenImages = state.kitchenImages;
    substate.masterBedroomImages = state.masterBedroomImages;
    substate.parlourImages = state.parlourImages;
    substate.secondBedroomImages = state.secondBedroomImages;
    substate.studyRoomImages = state.studyRoomImages;
    return substate;
  }

  @override
  void set(DecorateState state, HouseDetailState subState) {
    state.titleImage = subState.titleImage;
    state.balconyImages = subState.balconyImages;
    state.corridorImages = subState.corridorImages;
    state.houseTypeImages = subState.houseTypeImages;
    state.kitchenImages = subState.kitchenImages;
    state.masterBedroomImages = subState.masterBedroomImages;
    state.parlourImages = subState.parlourImages;
    state.secondBedroomImages = subState.secondBedroomImages;
    state.studyRoomImages = subState.studyRoomImages;
    state.houseDetailState = subState;
  }
}
