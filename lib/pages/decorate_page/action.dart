import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum DecorateAction {
  action,
  selectHouseType,
  selectHouseArea,
  selectHouseLocation,
  updateMaisonette,
  updataHouseLocation,
  updataHouseArea,
  updataHouseBudget,
  updateNeeds,
}

class DecorateActionCreator {
  static Action onAction() {
    return const Action(DecorateAction.action);
  }

  static Action updateMaisonette(String maisonette) {
    return Action(DecorateAction.updateMaisonette, payload: maisonette);
  }

  static Action selectHouseType(String houseType) {
    return Action(DecorateAction.selectHouseType, payload: houseType);
  }

  static Action selectHouseArea(double houseArea) {
    return Action(DecorateAction.selectHouseType, payload: houseArea);
  }

  static Action selectHouseLocation() {
    return Action(DecorateAction.selectHouseLocation);
  }

  static Action updataHouseLocation(String houseLocation) {
    return Action(DecorateAction.updataHouseLocation, payload: houseLocation);
  }

  static Action updataHouseArea(String houseArea) {
    return Action(DecorateAction.updataHouseArea, payload: houseArea);
  }

  static Action updataHouseBudget(String houseBudget) {
    return Action(DecorateAction.updataHouseBudget, payload: houseBudget);
  }

  static Action updateNeeds(String need, String type) {
    return Action(DecorateAction.updateNeeds, payload: [need, type]);
  }
}
