import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<ArticleDetailState> buildEffect() {
  return combineEffects(<Object, Effect<ArticleDetailState>>{
    ArticleDetailAction.action: _onAction,
  });
}

void _onAction(Action action, Context<ArticleDetailState> ctx) {
}
