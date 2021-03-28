import 'package:bluespace/pages/decorate_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class HouseDetailState implements Cloneable<HouseDetailState> {
  TextEditingController titleController;
  TextEditingController detailController;
  TextEditingController houseTypeController;
  TextEditingController parlourController;
  TextEditingController kitchenController;
  TextEditingController masterBedroomController;
  TextEditingController secondBedroomController;
  TextEditingController studyRoomController;
  TextEditingController toiletController;
  TextEditingController balconyController;
  TextEditingController corridorController;
  FocusNode titleFocusNode;
  Asset titleImage;
  List<Asset> houseTypeImages = [];
  List<Asset> titleImages = [];

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
      ..detailController = detailController
      ..titleFocusNode = titleFocusNode
      ..houseTypeImages = houseTypeImages
      ..titleImage = titleImage
      ..titleImages = titleImages
      ..parlourImages = parlourImages
      ..kitchenImages = kitchenImages
      ..masterBedroomImages = masterBedroomImages
      ..secondBedroomImages = secondBedroomImages
      ..studyRoomImages = studyRoomImages
      ..toiletImages = toiletImages
      ..balconyImages = balconyImages
      ..corridorImages = corridorImages
      ..parlourController = parlourController
      ..kitchenController = kitchenController
      ..masterBedroomController = masterBedroomController
      ..secondBedroomController = secondBedroomController
      ..studyRoomController = studyRoomController
      ..toiletController = toiletController
      ..balconyController = balconyController
      ..corridorController = corridorController;
  }
}

class HouseDetailConnector extends ConnOp<DecorateState, HouseDetailState> {
  @override
  HouseDetailState get(DecorateState state) {
    HouseDetailState substate = new HouseDetailState();
    substate.titleController = state.titleController;
    substate.titleImage = state.titleImage;
    substate.balconyImages = state.balconyImages;
    substate.corridorImages = state.corridorImages;
    substate.houseTypeImages = state.houseTypeImages;
    substate.kitchenImages = state.kitchenImages;
    substate.masterBedroomImages = state.masterBedroomImages;
    substate.parlourImages = state.parlourImages;
    substate.secondBedroomImages = state.secondBedroomImages;
    substate.studyRoomImages = state.studyRoomImages;
    substate.toiletImages = state.toiletImages;
    return substate;
  }

  @override
  void set(DecorateState state, HouseDetailState subState) {
    state.titleController = subState.titleController;
    state.titleImage = subState.titleImage;
    state.balconyImages = subState.balconyImages;
    state.corridorImages = subState.corridorImages;
    state.houseTypeImages = subState.houseTypeImages;
    state.kitchenImages = subState.kitchenImages;
    state.masterBedroomImages = subState.masterBedroomImages;
    state.parlourImages = subState.parlourImages;
    state.secondBedroomImages = subState.secondBedroomImages;
    state.studyRoomImages = subState.studyRoomImages;
    state.toiletImages = subState.toiletImages;
    state.houseDetailState = subState;
  }
}
