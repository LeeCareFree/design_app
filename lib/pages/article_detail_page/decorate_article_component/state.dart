import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/pages/article_detail_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class DecorateArticleState implements Cloneable<DecorateArticleState> {
  ArticleInfo articleInfo;
  @override
  DecorateArticleState clone() {
    return DecorateArticleState()..articleInfo = articleInfo;
  }
}

class DecorateArticleConnector
    extends ConnOp<ArticleDetailState, DecorateArticleState> {
  @override
  DecorateArticleState get(ArticleDetailState state) {
    DecorateArticleState substate = new DecorateArticleState();
    substate.articleInfo = state.articleInfo;
    return substate;
  }
}
