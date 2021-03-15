import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeSwiperState> buildEffect() {
  return combineEffects(<Object, Effect<HomeSwiperState>>{
    HomeSwiperAction.action: _onAction,
  });
}

void _onAction(Action action, Context<HomeSwiperState> ctx) {
}
