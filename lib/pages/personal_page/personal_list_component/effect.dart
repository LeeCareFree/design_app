import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<PersonalListState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalListState>>{
    PersonalListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<PersonalListState> ctx) {
}
