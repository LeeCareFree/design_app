import 'package:bule_space/pages/index_page/action.dart';
import 'package:bule_space/widgets/keekAliveWidget.dart';
import 'package:fish_redux/fish_redux.dart';
import 'state.dart';

Effect<IndexState> buildEffect() {
  return combineEffects(<Object, Effect<IndexState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<IndexState> ctx) async {
  dynamic pageList = [
    keepAliveWrapper(
      ctx.buildComponent('homePage'),
    ),
    // keepAliveWrapper(
    //   ctx.buildComponent('classPage'),
    // ),
    // keepAliveWrapper(
    //   ctx.buildComponent('prefecturePage'),
    // ),
    // keepAliveWrapper(
    //   ctx.buildComponent('minePage'),
    // ),
  ];
  ctx.dispatch(IndexActionCreator.initPageList(pageList));
}
