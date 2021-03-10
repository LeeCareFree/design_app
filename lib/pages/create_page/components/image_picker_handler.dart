import 'dart:async';
import 'dart:io';

import 'package:bluespace/pages/create_page/components/image_picker_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  ImagePickerDialog imagePicker;
  // AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener);

  openCamera() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _listener.userImage(image);
    // cropImage(image);
  }

  openGallery() async {
    imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _listener.userImage(image);
    // cropImage(image);
  }

  void init() {
    print('init');
    imagePicker = new ImagePickerDialog(this);
    imagePicker.initState();
  }

  // Future cropImage(File image) async {
  //   File croppedFile = await ImageCropper.cropImage(
  //     sourcePath: image.path,
  //     ratioX: 1.0,
  //     ratioY: 1.0,
  //     maxWidth: 512,
  //     maxHeight: 512,
  //   );
  //   _listener.userImage(croppedFile);
  // }

  showDialog(BuildContext context) {
    print('11111');
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  userImage(File _image);
}
