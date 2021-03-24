import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

//TODO replace with your own action
enum HouseDetailAction {
  action,
  setTitlePicture,
  upDateTitleImages,
  setIsshowDesc
}

class HouseDetailActionCreator {
  static Action onAction() {
    return const Action(HouseDetailAction.action);
  }

  static Action setTitlePicture() {
    return const Action(HouseDetailAction.setTitlePicture);
  }

  static Action upDateTitleImages(Asset newImage) {
    return Action(HouseDetailAction.upDateTitleImages, payload: newImage);
  }

  static Action setIsshowDesc(bool isShowDesc) {
    return Action(HouseDetailAction.setIsshowDesc, payload: isShowDesc);
  }
}
