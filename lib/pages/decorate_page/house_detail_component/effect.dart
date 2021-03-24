import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'action.dart';
import 'state.dart';

Effect<HouseDetailState> buildEffect() {
  return combineEffects(<Object, Effect<HouseDetailState>>{
    HouseDetailAction.action: _onAction,
    HouseDetailAction.setTitlePicture: _onSetTitlePicture,
    Lifecycle.initState: _onInit
  });
}

void _onSetTitlePicture(Action action, Context<HouseDetailState> ctx) async {
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
  print(resultList);
  if (resultList.length >= 1) {
    // print(resultList);
    ctx.dispatch(HouseDetailActionCreator.upDateTitleImages(resultList[0]));
  }
}

void _onInit(Action action, Context<HouseDetailState> ctx) {
  ctx.state..titleFocusNode = FocusNode();
  ctx.state.titleController = TextEditingController();
  ctx.state.houseTypeController = TextEditingController();
}

void _onAction(Action action, Context<HouseDetailState> ctx) {}
