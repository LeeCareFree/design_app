import 'dart:convert';

import 'package:bluespace/net/service_method.dart';
import 'package:dio/dio.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<DecorateState> buildEffect() {
  return combineEffects(<Object, Effect<DecorateState>>{
    DecorateAction.action: _onAction,
    DecorateAction.setTitlePicture: _onSetTitlePicture,
    DecorateAction.selectImgs: _onSelectImgs,
    DecorateAction.selectHouseLocation: _onSelectHouseLocation,
    DecorateAction.selectHouseArea: _onSelectHouseArea,
    DecorateAction.publishArticle: _onPublishArticle,
    Lifecycle.initState: _onInit
  });
}

void _onSelectImgs(Action action, Context<DecorateState> ctx) async {
  switch (action.payload) {
    case 'houseType':
      _onPickImgs(ctx.state.houseTypeImages, ctx, 'houseType');
      break;
    case 'parlour':
      _onPickImgs(ctx.state.parlourImages, ctx, 'parlour');
      break;
    case 'kitchen':
      _onPickImgs(ctx.state.kitchenImages, ctx, 'kitchen');
      break;
    case 'masterBedroom':
      _onPickImgs(ctx.state.masterBedroomImages, ctx, 'masterBedroom');
      break;
    case 'secondBedroom':
      _onPickImgs(ctx.state.secondBedroomImages, ctx, 'secondBedroom');
      break;
    case 'toilet':
      _onPickImgs(ctx.state.toiletImages, ctx, 'toilet');
      break;
    case 'studyRoom':
      _onPickImgs(ctx.state.studyRoomImages, ctx, 'studyRoom');
      break;
    case 'balcony':
      _onPickImgs(ctx.state.balconyImages, ctx, 'balcony');
      break;
    case 'corridor':
      _onPickImgs(ctx.state.corridorImages, ctx, 'corridor');
      break;
  }
}

void _onPickImgs(
    List<Asset> imgs, Context<DecorateState> ctx, String type) async {
  List<Asset> imgList = [];
  imgList = await MultiImagePicker.pickImages(
    //最多选择几张照片
    maxImages: 4,
    //是否可以拍照
    enableCamera: true,
    selectedAssets: imgs ?? [],
    materialOptions: MaterialOptions(
        startInAllView: true,
        allViewTitle: '所有照片',
        actionBarColor: '#2196F3',
        //未选择图片时提示
        textOnNothingSelected: '没有选择照片',
        //选择图片超过限制弹出提示
        selectionLimitReachedText: "最多选择4张照片"),
  );

  if (imgList.length >= 1) {
    ctx.dispatch(DecorateActionCreator.updateImgs(imgList, type));
  }
}

void _onSetTitlePicture(Action action, Context<DecorateState> ctx) async {
  List<Asset> resultList = [];
  resultList = await MultiImagePicker.pickImages(
    //最多选择几张照片
    maxImages: 1,
    //是否可以拍照
    enableCamera: true,
    selectedAssets: ctx.state.titleImages,
    materialOptions: MaterialOptions(
        startInAllView: true,
        allViewTitle: '所有照片',
        actionBarColor: '#2196F3',
        //未选择图片时提示
        textOnNothingSelected: '没有选择照片',
        //选择图片超过限制弹出提示
        selectionLimitReachedText: "最多选择1张照片"),
  );
  if (resultList.length >= 1) {
    ctx.dispatch(DecorateActionCreator.upDateTitleImages(resultList[0]));
  }
}

void _onPublishArticle(Action action, Context<DecorateState> ctx) async {
  String houseType = ctx.state.houseType;
  String houseArea = ctx.state.houseArea;
  String location = ctx.state.houseLocation;
  String budget = ctx.state.houseBudget;
  String maisonette = ctx.state.maisonette;
  // 介绍
  String detailDesc = ctx.state.detailController.text;
  // 标题
  String title = ctx.state.titleController.text;
// 户型图描述
  String houseTypeDesc = ctx.state.houseTypeController.text;
  // 客厅图描述
  String parlourDesc = ctx.state.parlourController.text;
  // 厨房图描述
  String kitchenDesc = ctx.state.kitchenController.text;
  // 主卧描述
  String masterBedroomDesc = ctx.state.masterBedroomController.text;
  // 次卧描述
  String secondBedroomDesc = ctx.state.secondBedroomController.text;
  // 卫生间描述
  String toiletDesc = ctx.state.toiletController.text;
  // 书房描述
  String studyRoomDesc = ctx.state.studyRoomController.text;
  // 阳台描述
  String balconyDesc = ctx.state.balconyController.text;
  // 走廊描述
  String corridorDesc = ctx.state.corridorController.text;
  if ((houseType != '' &&
          houseArea != '' &&
          location != '' &&
          budget != '' &&
          maisonette != '' &&
          title != '' &&
          detailDesc != '') &&
      (ctx.state.titleImage != null ||
          ctx.state.toiletImages != null ||
          ctx.state.balconyImages != null ||
          ctx.state.kitchenImages != null ||
          ctx.state.parlourImages != null ||
          ctx.state.corridorImages != null ||
          ctx.state.houseTypeImages != null ||
          ctx.state.studyRoomImages != null ||
          ctx.state.masterBedroomImages != null ||
          ctx.state.secondBedroomImages != null ||
          houseTypeDesc != '' ||
          parlourDesc != '' ||
          kitchenDesc != '' ||
          masterBedroomDesc != '' ||
          secondBedroomDesc != '' ||
          toiletDesc != '' ||
          studyRoomDesc != '' ||
          balconyDesc != '' ||
          corridorDesc != '')) {
    // 户型图描述
    var houseTypeImgList = await getImgs(ctx.state.houseTypeImages);
    // 客厅图描述
    var parlourImgList = await getImgs(ctx.state.parlourImages);
    // 厨房图描述
    var kitchenImgList = await getImgs(ctx.state.kitchenImages);
    // 主卧描述
    var masterBedroomImgList = await getImgs(ctx.state.masterBedroomImages);
    // 次卧描述
    var secondBedroomImgList = await getImgs(ctx.state.secondBedroomImages);
    // 卫生间描述
    var toiletImgList = await getImgs(ctx.state.titleImages);
    // 书房描述
    var studyRoomImgList = await getImgs(ctx.state.studyRoomImages);
    // 阳台描述
    var balconyImgList = await getImgs(ctx.state.balconyImages);
    // 走廊描述
    var corridorImgList = await getImgs(ctx.state.corridorImages);
    String houseStyle = ctx.state.houseStyle;
    String duration = ctx.state.duration;
    String needs = ctx.state.needsController.text;
    ByteData byteData = await ctx.state.titleImage.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    MultipartFile titleImg = new MultipartFile.fromBytes(
      imageData,
      //这个字段要有，否则后端接收为null
      filename: ctx.state.titleImage.name,
      //请求contentType，设置一下，不设置的话默认的是application/octet/stream，后台可以接收到数据，但上传后是.octet-stream文件
      contentType: MediaType("image", "jpg"),
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid') ?? '';
    FormData formData = new FormData.fromMap({
      //后端要用multipartFiles接收参数，否则为null
      // 图片
      'type': 1,
      'uid': uid,
      'title': title,
      'detail': detailDesc,
      'doorModel': houseType,
      'area': houseArea,
      'cost': budget,
      'location': location,
      'duplex': maisonette,
      'decoratestyle': houseStyle,
      'decorateduration': duration,
      'decorateother': needs,
      'floorplan': houseTypeImgList,
      'drawingroom': parlourImgList,
      'kitchen': kitchenImgList,
      'masterbedroom': masterBedroomImgList,
      'secondarybedroom': secondBedroomImgList,
      'toilet': toiletImgList,
      'study': studyRoomImgList,
      'balcony': balconyImgList,
      'corridor': corridorImgList,
      'cover': titleImg,
      "desc": {
        "floorplan": houseTypeDesc,
        "drawingroom": parlourDesc,
        "kitchen": kitchenDesc,
        "masterbedroom": masterBedroomDesc,
        "secondarybedroom": secondBedroomDesc,
        "toilet": toiletDesc,
        "study": studyRoomDesc,
        "balcony": balconyDesc,
        "corridor": corridorDesc
      }
    });
    var data = await DioUtil.request('create',
        formData: formData, context: ctx.context);
    data = json.decode(data.toString());
    if (data == null || data['code'] != 200) {
      Fluttertoast.showToast(msg: data['msg'] ?? '请稍后再试！');
    } else {
      Fluttertoast.showToast(msg: '发布成功');
      print(data['data']['aid']);
      Navigator.of(ctx.context).pushNamed('articleDetailPage',
          arguments: {'aid': data['data']['aid']});
    }
  } else {
    Fluttertoast.showToast(msg: '发布不能为空！');
  }
}

void _onSelectHouseLocation(Action action, Context<DecorateState> ctx) async {
  Result result = await CityPickers.showCityPicker(
    context: ctx.context,
  );
  String provinceName = result?.provinceName ?? '';
  String cityName = result?.cityName ?? '';
  String areaName = result?.areaName ?? '';
  ctx.dispatch(DecorateActionCreator.updataHouseLocation(
      provinceName + cityName + areaName));
}

void _onSelectHouseArea(Action action, Context<DecorateState> ctx) async {}

void _onAction(Action action, Context<DecorateState> ctx) {}
void _onInit(Action action, Context<DecorateState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.scrollController = ScrollController();
  ctx.state.tabController = TabController(length: 3, vsync: ticker);
  ctx.state.numberController = TextEditingController();
  ctx.state.needsController = TextEditingController();
  ctx.state..titleFocusNode = FocusNode();
  ctx.state.titleController = TextEditingController();
  ctx.state.houseTypeController = TextEditingController();
  ctx.state.detailController = TextEditingController();
  ctx.state.parlourController = TextEditingController();
  ctx.state.kitchenController = TextEditingController();
  ctx.state.masterBedroomController = TextEditingController();
  ctx.state.secondBedroomController = TextEditingController();
  ctx.state.studyRoomController = TextEditingController();
  ctx.state.toiletController = TextEditingController();
  ctx.state.balconyController = TextEditingController();
  ctx.state.corridorController = TextEditingController();
}

Future getImgs(List<Asset> oldImgs) async {
  if (oldImgs != null) {
    List<MultipartFile> imageList = new List<MultipartFile>();
    for (int i = 0; i < oldImgs.length; i++) {
      //将图片转为二进制数据
      ByteData byteData = await oldImgs[i].getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        //这个字段要有，否则后端接收为null
        filename: oldImgs[i].name,
        //请求contentType，设置一下，不设置的话默认的是application/octet/stream，后台可以接收到数据，但上传后是.octet-stream文件
        contentType: MediaType("image", "jpg"),
      );
      imageList.add(multipartFile);
    }
    return imageList;
  } else {
    return null;
  }
}
