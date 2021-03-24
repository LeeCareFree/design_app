import 'package:bluespace/pages/decorate_page/house_detail_component/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DecorateState implements Cloneable<DecorateState> {
  ScrollController scrollController;
  TabController tabController;
  TextEditingController numberController;
  String houseType;
  String houseArea;
  String houseLocation;
  String houseBudget;
  Asset titleImage;
  List<Asset> houseTypeImages;
  List<Asset> parlourImages;
  List<Asset> kitchenImages;
  List<Asset> masterBedroomImages;
  List<Asset> secondBedroomImages;
  List<Asset> studyRoomImages;
  List<Asset> toiletImages;
  List<Asset> balconyImages;
  List<Asset> corridorImages;
  HouseDetailState houseDetailState;
  @override
  DecorateState clone() {
    return DecorateState()
      ..numberController = numberController
      ..houseType = houseType
      ..houseArea = houseArea
      ..houseLocation = houseLocation
      ..houseBudget = houseBudget
      ..tabController = tabController
      ..houseDetailState = houseDetailState
      ..scrollController = scrollController
      ..titleImage = titleImage
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

DecorateState initState(Map<String, dynamic> args) {
  return DecorateState();
}
