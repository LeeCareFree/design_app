import 'package:bluespace/models/account_info.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PersonalAction {
  action,
  showTitle,
  getAccountInfo,
  initAccountInfo,
  setLoading,
  follow,
  updataIsFollow,
  getArticleList,
  upDateArticleList,
  initArticle,
  navigatorPush,
  back,
}

class PersonalActionCreator {
  static Action onAction() {
    return const Action(PersonalAction.action);
  }

  static Action navigatorPush(String routerName, Object arguments) {
    return Action(PersonalAction.navigatorPush,
        payload: [routerName, arguments]);
  }

  static Action back() {
    return const Action(PersonalAction.back);
  }

  static Action initArticle(int type, List list) {
    return Action(PersonalAction.initArticle, payload: [type, list]);
  }

  static Action upDateArticleList(int type, List articleList, int pageIndex) {
    return Action(PersonalAction.upDateArticleList,
        payload: [type, articleList, pageIndex]);
  }

  static Action getArticleList(int page, int type) {
    return Action(PersonalAction.getArticleList, payload: [page, type]);
  }

  static Action updataIsFollow(bool isFollow) {
    return Action(PersonalAction.updataIsFollow, payload: isFollow);
  }

  static Action follow(String type) {
    return Action(PersonalAction.follow, payload: type);
  }

  static Action getAccountInfo() {
    return const Action(PersonalAction.getAccountInfo);
  }

  static Action setLoading(bool loading) {
    return Action(PersonalAction.setLoading, payload: loading);
  }

  static Action initAccountInfo(AccountInfo accountInfo) {
    return Action(PersonalAction.initAccountInfo, payload: accountInfo);
  }

  static Action showTitle() {
    return const Action(PersonalAction.showTitle);
  }
}
