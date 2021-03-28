import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DecorateArticleState> buildReducer() {
  return asReducer(
    <Object, Reducer<DecorateArticleState>>{
      DecorateArticleAction.action: _onAction,
    },
  );
}

DecorateArticleState _onAction(DecorateArticleState state, Action action) {
  final DecorateArticleState newState = state.clone();
  return newState;
}
