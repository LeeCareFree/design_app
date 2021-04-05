import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

//TODO replace with your own action
enum PersonalSettingAction {
  action,
  submit,
  pickImg,
  setImg,
  setContent,
  pickLocation,
  back
}

class PersonalSettingActionCreator {
  static Action onAction() {
    return const Action(PersonalSettingAction.action);
  }

  static Action back(AccountInfo accountInfo) {
    return Action(PersonalSettingAction.back, payload: accountInfo);
  }

  static Action pickImg(String type) {
    return Action(PersonalSettingAction.pickImg, payload: type);
  }

  static Action setImg(String type, Asset asset) {
    return Action(PersonalSettingAction.setImg, payload: [type, asset]);
  }

  static Action pickLocation() {
    return Action(PersonalSettingAction.pickLocation);
  }

  static Action setContent(String type, String content) {
    return Action(PersonalSettingAction.setContent, payload: [type, content]);
  }

  static Action submit() {
    return const Action(PersonalSettingAction.submit);
  }
}
