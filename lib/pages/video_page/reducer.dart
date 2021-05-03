import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VideoState> buildReducer() {
  return asReducer(
    <Object, Reducer<VideoState>>{
      VideoAction.action: _onAction,
      VideoAction.setLoading: _setLoading,
      VideoAction.initArticle: _onInitArticle,
      VideoAction.updataStatus: _onUpdataStatus,
    },
  );
}

VideoState _onAction(VideoState state, Action action) {
  final VideoState newState = state.clone();
  return newState;
}

VideoState _setLoading(VideoState state, Action action) {
  final bool _loading = action.payload;
  final VideoState newState = state.clone();
  newState.isLoading = _loading;
  return newState;
}

VideoState _onInitArticle(VideoState state, Action action) {
  final VideoState newState = state.clone();
  newState.articleInfo = action.payload;
  newState.videoList = [action.payload];
  return newState;
}

VideoState _onUpdataStatus(VideoState state, Action action) {
  final VideoState newState = state.clone();
  switch (action.payload[0]) {
    case 'isLike':
      newState.isLike = action.payload[1];
      break;
    case 'isColl':
      newState.isColl = action.payload[1];
      break;
    case 'isFollow':
      newState.isFollow = action.payload[1];
      break;
    default:
  }
  return newState;
}
