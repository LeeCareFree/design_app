import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalState>>{
      PersonalAction.action: _onAction,
      // PersonalAction.showTitle: _onShowTitle,
      Lifecycle.initState: _onInit
    },
  );
}

PersonalState _onAction(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  return newState;
}

PersonalState _onInit(PersonalState state, Action action) {
  print('111');
  final PersonalState newState = state.clone();
  newState
    ..isShowTitle = state.scrollController.hasClients &&
        state.scrollController.offset > Adapt.height(350);
  return newState;
}
