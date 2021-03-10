import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<OrderComponentState> buildReducer() {
  return asReducer(
    <Object, Reducer<OrderComponentState>>{
      OrderComponentAction.action: _onAction,
    },
  );
}

OrderComponentState _onAction(OrderComponentState state, Action action) {
  final OrderComponentState newState = state.clone();
  return newState;
}
