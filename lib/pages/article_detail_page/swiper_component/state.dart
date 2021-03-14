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
    // substate.backdrops = state.imagesmodel?.backdrops;
    substate.backdrops = [
      'http://192.168.0.105:3000/upload/publish/1.jpeg',
      'http://192.168.0.105:3000/upload/publish/2.jpeg',
      'http://192.168.0.105:3000/upload/publish/3.jpeg'
    ];
    return substate;
  }
}
