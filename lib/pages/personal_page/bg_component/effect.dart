import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<BgState> buildEffect() {
  return combineEffects(<Object, Effect<BgState>>{
    BgAction.action: _onAction,
  });
}

void _onAction(Action action, Context<BgState> ctx) {
}
