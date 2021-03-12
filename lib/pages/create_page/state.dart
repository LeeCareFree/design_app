import 'dart:io';

import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CreateState implements Cloneable<CreateState> {
  List<Asset> images = [];
  String selectedVal;
  @override
  CreateState clone() {
    return CreateState()
      ..images = images
      ..selectedVal = selectedVal;
  }
}

CreateState initState(Map<String, dynamic> args) {
  return CreateState()..images = [];
}
