import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<PersonalState> buildEffect() {
  return combineEffects(<Object, Effect<PersonalState>>{
    PersonalAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<PersonalState> ctx) {}

void _onInit(Action action, Context<PersonalState> ctx) {
  final Object ticker = ctx.stfState;
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
  ctx.state.scrollController = ScrollController();
  ctx.state.tabController = TabController(length: 3, vsync: ticker);
}

void _onDispose(Action action, Context<PersonalState> ctx) {
  ctx.state.animationController?.dispose();
  ctx.state.scrollController?.dispose();
}
