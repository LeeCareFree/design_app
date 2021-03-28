import 'package:bluespace/pages/article_detail_page/decorate_article_component/component.dart';
import 'package:bluespace/pages/article_detail_page/decorate_article_component/state.dart';
import 'package:bluespace/pages/article_detail_page/swiper_component/component.dart';
import 'package:bluespace/pages/article_detail_page/swiper_component/state.dart';
import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ArticleDetailPage extends Page<ArticleDetailState, Map<String, dynamic>> {
  ArticleDetailPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<ArticleDetailState>(
              adapter: null,
              slots: <String, Dependent<ArticleDetailState>>{
                'swiper': SwiperConnector() + SwiperComponent(),
                'decorateArticle': DecorateArticleConnector() + DecorateArticleComponent()
              }),
          middleware: <Middleware<ArticleDetailState>>[],
        );
}
