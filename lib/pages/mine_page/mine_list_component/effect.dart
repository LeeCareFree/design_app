import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<MineListState> buildEffect() {
  return combineEffects(<Object, Effect<MineListState>>{
    MineListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<MineListState> ctx) {
}
