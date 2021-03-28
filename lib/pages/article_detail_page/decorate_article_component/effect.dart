import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<DecorateArticleState> buildEffect() {
  return combineEffects(<Object, Effect<DecorateArticleState>>{
    DecorateArticleAction.action: _onAction,
  });
}

void _onAction(Action action, Context<DecorateArticleState> ctx) {
}
