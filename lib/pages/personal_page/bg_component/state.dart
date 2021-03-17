import 'package:bluespace/pages/personal_page/state.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class BgState implements Cloneable<BgState> {
  String bgPic;
  ScrollController scrollController;
  @override
  BgState clone() {
    return BgState();
  }
}

class BgConnector extends ConnOp<PersonalState, BgState> {
  @override
  BgState get(PersonalState state) {
    BgState substate = BgState();
    substate.bgPic = state.bgPic;
    substate.scrollController = state.scrollController;
    return substate;
  }
}
