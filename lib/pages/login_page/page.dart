/*
 * @Author: your name
 * @Date: 2020-10-10 11:09:12
 * @LastEditTime: 2020-10-10 16:33:01
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\login_page\page.dart
 */
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LoginPage extends Page<LoginPageState, Map<String, dynamic>> with TickerProviderMixin<LoginPageState>{
  LoginPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LoginPageState>(
                adapter: null,
                slots: <String, Dependent<LoginPageState>>{
                }),
            middleware: <Middleware<LoginPageState>>[
            ],);
}
