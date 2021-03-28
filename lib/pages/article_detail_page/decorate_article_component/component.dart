import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DecorateArticleComponent extends Component<DecorateArticleState> {
  DecorateArticleComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<DecorateArticleState>(
                adapter: null,
                slots: <String, Dependent<DecorateArticleState>>{
                }),);

}
