import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<OrderComponentState> buildEffect() {
  return combineEffects(<Object, Effect<OrderComponentState>>{
    OrderComponentAction.action: _onAction,
  });
}

void _onAction(Action action, Context<OrderComponentState> ctx) {}
