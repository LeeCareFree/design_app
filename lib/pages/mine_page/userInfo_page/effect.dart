import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<UserInfoState> buildEffect() {
  return combineEffects(<Object, Effect<UserInfoState>>{
    UserInfoAction.action: _onAction,
  });
}

void _onAction(Action action, Context<UserInfoState> ctx) {
}
