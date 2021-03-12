import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PublishState> buildReducer() {
  return asReducer(
    <Object, Reducer<PublishState>>{
      PublishAction.action: _onAction,
      PublishAction.upDateImages: _upDateImages,
    },
  );
}

PublishState _onAction(PublishState state, Action action) {
  final PublishState newState = state.clone();
  return newState;
}

PublishState _upDateImages(PublishState state, Action action) {
  final PublishState newState = state.clone();
  newState.images = action.payload;
  return newState;
}
