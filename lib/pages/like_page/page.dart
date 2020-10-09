import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class LikePage extends Page<LikeState, Map<String, dynamic>> {
  LikePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<LikeState>(
                adapter: null,
                slots: <String, Dependent<LikeState>>{
                }),
            middleware: <Middleware<LikeState>>[
            ],);

}
