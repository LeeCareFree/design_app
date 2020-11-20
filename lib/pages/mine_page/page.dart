/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:38
 * @LastEditTime: 2020-10-09 18:43:02
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\page.dart
 */
import 'package:bluespace/pages/mine_page/header_component/component.dart';
import 'package:bluespace/pages/mine_page/header_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MinePage extends Page<MineState, Map<String, dynamic>> with TickerProviderMixin<MineState> {
  MinePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MineState>(
                adapter: null,
                slots: <String, Dependent<MineState>>{
                  'header': HeaderConnector() + HeaderComponent(),
                }),
            middleware: <Middleware<MineState>>[
            ],);

}
