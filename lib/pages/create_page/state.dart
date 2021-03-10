import 'dart:io';

import 'package:bluespace/pages/create_page/components/image_picker_handler.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';

class CreateState implements Cloneable<CreateState> {
  ImagePickerHandler imagePicker;
  // AnimationController showImgAnimationController;
  File _image;
  String selectedVal;
  @override
  CreateState clone() {
    return CreateState()
      // ..showImgAnimationController = showImgAnimationController
      ..imagePicker = imagePicker
      ..selectedVal = selectedVal
      .._image = _image;
  }
}

CreateState initState(Map<String, dynamic> args) {
  // state._image = null;
  // ImagePickerHandler imagePicker;
  // state.imagePicker = new ImagePickerHandler(state._listener);
  return CreateState();
}
