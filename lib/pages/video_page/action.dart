import 'package:bluespace/models/article_detail.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VideoAction {
  action,
  getArticle,
  checkStatus,
  getUserAvatar,
  follow,
  updataStatus,
  initArticle,
  setLoading,
  likeHandle,
  collHandle,
  publishComment,
  deleteComment,
  deleteArticle
}

class VideoActionCreator {
  static Action onAction() {
    return const Action(VideoAction.action);
  }

  static Action deleteArticle() {
    return const Action(VideoAction.deleteArticle);
  }

  static Action deleteComment(String cid) {
    return Action(VideoAction.deleteComment, payload: cid);
  }

  static Action publishComment() {
    return const Action(VideoAction.publishComment);
  }

  static Action likeHandle(String type) {
    return Action(VideoAction.likeHandle, payload: type);
  }

  static Action collHandle(String type) {
    return Action(VideoAction.collHandle, payload: type);
  }

  static Action initArticle(ArticleInfo articleDetail) {
    return Action(VideoAction.initArticle, payload: articleDetail);
  }

  static Action setLoading(bool loading) {
    return Action(VideoAction.setLoading, payload: loading);
  }

  static Action getArticle() {
    return Action(VideoAction.getArticle);
  }

  static Action checkStatus() {
    return Action(VideoAction.checkStatus);
  }

  static Action updataStatus(String type, bool res) {
    return Action(VideoAction.updataStatus, payload: [type, res]);
  }

  static Action getUserAvatar() {
    return Action(VideoAction.getUserAvatar);
  }

  static Action follow(String type) {
    return Action(VideoAction.follow, payload: type);
  }
}
