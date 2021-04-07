import 'package:bluespace/models/designer_list.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SortAction { action, tapHead, getDesignerList, initDesignerList }

class SortActionCreator {
  static Action onAction() {
    return const Action(SortAction.action);
  }

  static Action getDesignerList() {
    return Action(
      SortAction.getDesignerList,
    );
  }

  static Action tapHead(int index) {
    return Action(SortAction.tapHead, payload: index);
  }

  static Action initDesignerList(DesignerList designerList) {
    return Action(SortAction.initDesignerList, payload: designerList);
  }
}
