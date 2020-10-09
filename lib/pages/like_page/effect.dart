import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<LikeState> buildEffect() {
  return combineEffects(<Object, Effect<LikeState>>{
    LikeAction.action: _onAction,
  });
}

void _onAction(Action action, Context<LikeState> ctx) {
}
