/*
 * @Author: your name
 * @Date: 2020-10-09 18:38:25
 * @LastEditTime: 2020-10-09 18:50:05
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\header_component\state.dart
 */
import 'package:bluespace/models/app_user.dart';
import 'package:bluespace/pages/mine_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class HeaderState implements Cloneable<HeaderState> {
  AppUser user;
  @override
  HeaderState clone() {
    return HeaderState();
  }
}
class HeaderConnector extends ConnOp<MineState, HeaderState> {
  @override
  HeaderState get(MineState state) {
    HeaderState subState = new HeaderState();
    subState.user = state.user;
    return subState;
  }
}

