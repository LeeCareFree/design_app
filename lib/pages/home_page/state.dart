import 'package:fish_redux/fish_redux.dart';

class HomeState implements Cloneable<HomeState> {
  
  List bannerList;
  List articleList;

  HomeState({this.bannerList, this.articleList});

  @override
  HomeState clone() {
    return HomeState()
      ..bannerList = bannerList
      ..articleList = articleList;
  }
}

HomeState initState(Map<String, dynamic> args) {
  return HomeState()
    ..bannerList = new List()
    ..articleList = new List();
}
