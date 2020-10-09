import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SortState> buildEffect() {
  return combineEffects(<Object, Effect<SortState>>{
    SortAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SortState> ctx) {
}
