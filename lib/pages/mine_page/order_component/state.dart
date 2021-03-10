import 'package:bluespace/pages/mine_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class OrderComponentState implements Cloneable<OrderComponentState> {
  @override
  OrderComponentState clone() {
    return OrderComponentState();
  }
}

class OrderComponentConnecter extends ConnOp<MineState, OrderComponentState> {
  @override
  OrderComponentState get(MineState state) {
    OrderComponentState substate = state.orderState.clone();
    // substate.user = state.user;
    return substate;
  }

  @override
  void set(MineState state, OrderComponentState subState) {
    state.orderState = subState;
  }
}
