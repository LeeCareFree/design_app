import 'package:bluespace/models/decorate_article.dart';
import 'package:bluespace/pages/article_detail_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class DecorateArticleState implements Cloneable<DecorateArticleState> {
  DecorateArticle decorateArticle;
  @override
  DecorateArticleState clone() {
    return DecorateArticleState()..decorateArticle = decorateArticle;
  }
}

class DecorateArticleConnector
    extends ConnOp<ArticleDetailState, DecorateArticleState> {
  @override
  DecorateArticleState get(ArticleDetailState state) {
    DecorateArticleState substate = new DecorateArticleState();
    substate.decorateArticle = state.decorateArticle;
    return substate;
  }
}
