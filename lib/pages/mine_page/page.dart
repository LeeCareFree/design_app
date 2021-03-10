/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:38
 * @LastEditTime: 2020-10-09 18:43:02
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\page.dart
 */
import 'package:bluespace/pages/mine_page/mine_list_component/component.dart';
import 'package:bluespace/pages/mine_page/mine_list_component/state.dart';
import 'package:bluespace/pages/mine_page/order_component/component.dart';
import 'package:bluespace/pages/mine_page/order_component/state.dart';
import 'package:bluespace/pages/mine_page/user_info_component/component.dart';
import 'package:bluespace/pages/mine_page/user_info_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MinePage extends Page<MineState, Map<String, dynamic>>
    with TickerProviderMixin<MineState> {
  MinePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<MineState>(
              adapter: null,
              slots: <String, Dependent<MineState>>{
                'userInfo': UserInfoConnector() + UserInfoComponent(),
                'order': OrderComponentConnecter() + OrderComponent(),
                'mineList': MineListConnecter() + MineListComponent()
              }),
          middleware: <Middleware<MineState>>[],
        );
}
