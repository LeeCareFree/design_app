import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<MineListState> buildEffect() {
  return combineEffects(<Object, Effect<MineListState>>{
    MineListAction.action: _onAction,
    MineListAction.toArticlePage: _toArticlePage
  });
}

void _onAction(Action action, Context<MineListState> ctx) {}

void _toArticlePage(Action action, Context<MineListState> ctx) {
  Navigator.of(ctx.context).pushNamed('articleDetailPage');
}
