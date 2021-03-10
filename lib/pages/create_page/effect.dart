import 'package:bluespace/pages/create_page/components/image_picker_handler.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:image_picker/image_picker.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateState> buildEffect() {
  return combineEffects(<Object, Effect<CreateState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    CreateAction.action: _onAction,
    CreateAction.onShowImgClicked: _onShowImgClicked,
  });
}

void _onAction(Action action, Context<CreateState> ctx) {}

void _onInit(Action action, Context<CreateState> ctx) {
  // final TickerProvider ticker = ctx.stfState as TickerProvider;
  // ctx.state.showImgAnimationController = AnimationController(
  //   vsync: ticker,
  //   duration: const Duration(milliseconds: 500),
  // );
  print('init');
  // ctx.state.imagePicker = new ImagePickerHandler(ctx.state._listener);

  // ctx.state.imagePicker.init();
}

Future _onShowImgClicked(Action action, Context<CreateState> ctx) async {
  if (action.payload == '相机') {
    // ctx.state.showImgAnimationController.forward();
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var r = (await Navigator.of(ctx.context).pushNamed('publishPage')) as Map;
    // cropImage(image);
  } else if (action.payload == '相册') {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    var r = (await Navigator.of(ctx.context).pushNamed('publishPage')) as Map;
  }
  // imagePicker.showDialog(context)
}

void _onDispose(Action action, Context<CreateState> ctx) {
  // ctx.state.showImgAnimationController.dispose();
}
