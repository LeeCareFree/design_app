import 'package:bluespace/models/myhome_info.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MyhomeSettingAction {
  action,
  selectHouseType,
  selectHouseArea,
  selectHouseLocation,
  setHouseProgress,
  setPersoanlNum,
  setBeginTime,
  setIntoTime,
  updataHouseLocation,
  updataHouseArea,
  updataHouseBudget,
  submit,
  back
}

class MyhomeSettingActionCreator {
  static Action onAction() {
    return const Action(MyhomeSettingAction.action);
  }

  static Action back(MyhomeInfo myhomeInfo) {
    return Action(MyhomeSettingAction.back, payload: myhomeInfo);
  }

  static Action submit() {
    return const Action(MyhomeSettingAction.submit);
  }

  static Action setBeginTime(String time) {
    return Action(MyhomeSettingAction.setBeginTime, payload: time);
  }

  static Action setIntoTime(String time) {
    return Action(MyhomeSettingAction.setIntoTime, payload: time);
  }

  static Action setPersoanlNum(String persoanlNum) {
    return Action(MyhomeSettingAction.setPersoanlNum, payload: persoanlNum);
  }

  static Action setHouseProgress(String houseProgress) {
    return Action(MyhomeSettingAction.setHouseProgress, payload: houseProgress);
  }

  static Action selectHouseType(String houseType) {
    return Action(MyhomeSettingAction.selectHouseType, payload: houseType);
  }

  static Action selectHouseArea(double houseArea) {
    return Action(MyhomeSettingAction.selectHouseType, payload: houseArea);
  }

  static Action selectHouseLocation() {
    return Action(MyhomeSettingAction.selectHouseLocation);
  }

  static Action updataHouseLocation(String houseLocation) {
    return Action(MyhomeSettingAction.updataHouseLocation,
        payload: houseLocation);
  }

  static Action updataHouseArea(String houseArea) {
    return Action(MyhomeSettingAction.updataHouseArea, payload: houseArea);
  }

  static Action updataHouseBudget(String houseBudget) {
    return Action(MyhomeSettingAction.updataHouseBudget, payload: houseBudget);
  }
}
