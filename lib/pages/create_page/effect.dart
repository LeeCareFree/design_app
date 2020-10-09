import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<CreateState> buildEffect() {
  return combineEffects(<Object, Effect<CreateState>>{
    CreateAction.action: _onAction,
  });
}

void _onAction(Action action, Context<CreateState> ctx) {
}
