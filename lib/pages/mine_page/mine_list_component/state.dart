import 'package:bluespace/pages/mine_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class MineListState implements Cloneable<MineListState> {
  @override
  MineListState clone() {
    return MineListState();
  }
}

class MineListConnecter extends ConnOp<MineState, MineListState> {
  @override
  MineListState get(MineState state) {
    MineListState substate = state.mineListState.clone();
    // substate.user = state.user;
    return substate;
  }

  @override
  void set(MineState state, MineListState subState) {
    state.mineListState = subState;
  }
}
