import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class DecorateState implements Cloneable<DecorateState> {
  ScrollController scrollController;
  TabController tabController;
  TextEditingController numberController;
  TextEditingController needsController;
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
  String houseType;
  String houseArea;
  String houseLocation;
  String houseBudget;
  String houseStyle;
  String duration;
  String maisonette;
  List<Asset> titleImages = [];
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
  @override
  DecorateState clone() {
    return DecorateState()
      ..houseTypeController = houseTypeController
      ..titleController = titleController
      ..titleFocusNode = titleFocusNode
      ..detailController = detailController
      ..parlourController = parlourController
      ..kitchenController = kitchenController
      ..masterBedroomController = masterBedroomController
      ..secondBedroomController = secondBedroomController
      ..studyRoomController = studyRoomController
      ..toiletController = toiletController
      ..balconyController = balconyController
      ..corridorController = corridorController
      ..numberController = numberController
      ..needsController = needsController
      ..titleController = titleController
      ..houseType = houseType
      ..houseArea = houseArea
      ..houseLocation = houseLocation
      ..houseBudget = houseBudget
      ..houseStyle = houseStyle
      ..duration = duration
      ..maisonette = maisonette
      ..tabController = tabController
      ..scrollController = scrollController
      ..titleImages = titleImages
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
