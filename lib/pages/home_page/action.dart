import 'package:bluespace/models/article_list_data.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum HomeAction {
  action,
  getBanner,
  initBanner,
  searchBarTapped,
  getArticleList,
  initArticle,
  upDateArticleList
}

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action upDateArticleList(List articleList, int pageIndex) {
    return Action(HomeAction.upDateArticleList,
        payload: [articleList, pageIndex]);
  }

  static Action getBanner() {
    return Action(HomeAction.getBanner);
  }

  static Action initBanner(var list) {
    return Action(HomeAction.initBanner, payload: list);
  }

  static Action onSearchBarTapped() {
    return Action(HomeAction.searchBarTapped);
  }

  static Action getArticleList(int page, String way) {
    return Action(HomeAction.getArticleList, payload: [page, way]);
  }

  static Action initArticle(List list) {
    return Action(HomeAction.initArticle, payload: list);
  }
}
