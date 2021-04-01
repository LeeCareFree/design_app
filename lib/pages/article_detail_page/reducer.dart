import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ArticleDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<ArticleDetailState>>{
      ArticleDetailAction.action: _onAction,
      ArticleDetailAction.initArticle: _onInitArticle,
      ArticleDetailAction.upDatalikeCommentCount: _onUpDatalikeCommentCount,
      ArticleDetailAction.setLoading: _setLoading,
      ArticleDetailAction.completeComment: _onCompleteComment,
      ArticleDetailAction.updataIsLike: _onUpdataIsLike,
      ArticleDetailAction.updataIsColl: _onUpdataIsColl,
      ArticleDetailAction.updataIsFollow: _onupdataIsFollow
    },
  );
}

ArticleDetailState _onAction(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  return newState;
}

ArticleDetailState _onInitArticle(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  switch (state.articleType) {
    case '1':
      newState..articleInfo = action.payload;
      break;
    case '2':
      newState..articleInfo = action.payload;
      break;
  }

  return newState;
}

ArticleDetailState _onUpDatalikeCommentCount(
    ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  newState..commentLikeCount = state.commentLikeCount + 1;
  return newState;
}

ArticleDetailState _setLoading(ArticleDetailState state, Action action) {
  final bool _loading = action.payload;
  final ArticleDetailState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

ArticleDetailState _onCompleteComment(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  // newState..commentTextController = null;
  // newState..commentFocusNode = null;
  return newState;
}

ArticleDetailState _onUpdataIsLike(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  newState..isLike = action.payload;
  return newState;
}

ArticleDetailState _onUpdataIsColl(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  newState..isColl = action.payload;
  return newState;
}

ArticleDetailState _onupdataIsFollow(ArticleDetailState state, Action action) {
  final ArticleDetailState newState = state.clone();
  newState..isFollow = action.payload;
  return newState;
}
