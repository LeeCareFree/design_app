import 'package:fish_redux/fish_redux.dart';
import 'package:bluespace/models/slideshow_model.dart';

class HomeState implements Cloneable<HomeState> {
  
  List bannerList;

  HomeState({this.bannerList});

  @override
  HomeState clone() {
    return HomeState()
      ..bannerList = bannerList;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..bannerList = new List();
}
