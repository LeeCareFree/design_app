import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PersonalState> buildReducer() {
  return asReducer(
    <Object, Reducer<PersonalState>>{
      PersonalAction.action: _onAction,
      // PersonalAction.showTitle: _onShowTitle,
      PersonalAction.initAccountInfo: _onInitAccountInfo,
      Lifecycle.initState: _onInit,
      PersonalAction.setLoading: _setLoading,
    },
  );
}

PersonalState _setLoading(PersonalState state, Action action) {
  final bool _loading = action.payload;
  final PersonalState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

PersonalState _onAction(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  return newState;
}

PersonalState _onInitAccountInfo(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  newState..accountInfo = action.payload;
  return newState;
}

PersonalState _onInit(PersonalState state, Action action) {
  final PersonalState newState = state.clone();
  newState
    ..isShowTitle = state.scrollController.hasClients &&
        state.scrollController.offset > Adapt.height(350);
  return newState;
}
