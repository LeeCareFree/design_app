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
  upDateArticleList,
  goArticleDetail,
  updateDelArticle
}

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action updateDelArticle(String delAid) {
    return Action(HomeAction.updateDelArticle, payload: delAid);
  }

  static Action goArticleDetail(String routerName, Object arguments) {
    return Action(HomeAction.goArticleDetail, payload: [routerName, arguments]);
  }

  static Action upDateArticleList(int type, List articleList, int pageIndex) {
    return Action(HomeAction.upDateArticleList,
        payload: [type, articleList, pageIndex]);
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

  static Action getArticleList(int page, int way) {
    return Action(HomeAction.getArticleList, payload: [page, way]);
  }

  static Action initArticle(int type, List list) {
    return Action(HomeAction.initArticle, payload: [type, list]);
  }
}
