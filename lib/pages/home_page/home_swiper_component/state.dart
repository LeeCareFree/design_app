import 'package:fish_redux/fish_redux.dart';
import 'package:bluespace/pages/home_page/state.dart';

class HomeSwiperState implements Cloneable<HomeSwiperState> {
  List swiperDataList;

  @override
  HomeSwiperState clone() {
    return HomeSwiperState()..swiperDataList = swiperDataList;
  }
}

class HomeSwiperConnector extends ConnOp<HomeState, HomeSwiperState> {
  @override
  HomeSwiperState get(HomeState state) {
    HomeSwiperState substate = new HomeSwiperState();
    substate.swiperDataList = state.bannerList;
    return substate;
  }
}