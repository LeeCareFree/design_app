import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HomeSwiperState> buildReducer() {
  return asReducer(
    <Object, Reducer<HomeSwiperState>>{
      HomeSwiperAction.action: _onAction,
    },
  );
}

HomeSwiperState _onAction(HomeSwiperState state, Action action) {
  final HomeSwiperState newState = state.clone();
  return newState;
}
