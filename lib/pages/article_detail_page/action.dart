import 'package:bluespace/models/article_detail.dart';
import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ArticleDetailAction {
  action,
  openMenu,
  getArticle,
  initArticle,
  getUserAvatar,
  pubilshComment,
  deleteComment,
  likeComment,
  upDatalikeCommentCount,
  completeComment,
  setLoading,
  likeHandle,
  cancelLike,
  checkLikeStatus,
  updataIsLike,
  collHandle,
  cancelColl,
  checkCollStatus,
  updataIsColl,
}

class ArticleDetailActionCreator {
  static Action onAction() {
    return const Action(ArticleDetailAction.action);
  }

  static Action checkLikeStatus() {
    return const Action(ArticleDetailAction.checkLikeStatus);
  }

  static Action cancelLike() {
    return const Action(ArticleDetailAction.cancelLike);
  }

  static Action updataIsLike(bool isLike) {
    return Action(ArticleDetailAction.updataIsLike, payload: isLike);
  }

  static Action likeHandle() {
    return const Action(ArticleDetailAction.likeHandle);
  }

  static Action collHandle() {
    return const Action(ArticleDetailAction.collHandle);
  }

  static Action checkCollStatus() {
    return const Action(ArticleDetailAction.checkCollStatus);
  }

  static Action cancelColl() {
    return const Action(ArticleDetailAction.cancelColl);
  }

  static Action updataIsColl(bool isColl) {
    return Action(ArticleDetailAction.updataIsColl, payload: isColl);
  }

  static Action openMenu() {
    return Action(ArticleDetailAction.openMenu);
  }

  static Action initArticle(var articleDetail) {
    return Action(ArticleDetailAction.initArticle, payload: articleDetail);
  }

  static Action getArticle() {
    return Action(ArticleDetailAction.getArticle);
  }

  static Action getUserAvatar() {
    return Action(ArticleDetailAction.getUserAvatar);
  }

  static Action pubilshComment() {
    return Action(ArticleDetailAction.pubilshComment);
  }

  static Action deleteComment(String cid) {
    return Action(ArticleDetailAction.deleteComment, payload: cid);
  }

  static Action likeComment(String cid) {
    return Action(ArticleDetailAction.likeComment, payload: cid);
  }

  static Action upDatalikeCommentCount() {
    return Action(ArticleDetailAction.upDatalikeCommentCount);
  }

  static Action setLoading(bool loading) {
    return Action(ArticleDetailAction.setLoading, payload: loading);
  }

  static Action completeComment() {
    return Action(ArticleDetailAction.completeComment);
  }
}
