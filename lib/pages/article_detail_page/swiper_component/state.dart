import 'package:bluespace/pages/article_detail_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class SwiperState implements Cloneable<SwiperState> {
  List<String> backdrops;
  @override
  SwiperState clone() {
    return SwiperState()..backdrops = backdrops;
  }
}

class SwiperConnector extends ConnOp<ArticleDetailState, SwiperState> {
  @override
  SwiperState get(ArticleDetailState state) {
    SwiperState substate = new SwiperState();
    substate.backdrops = state.articleInfo?.imgList;
    return substate;
  }
}
