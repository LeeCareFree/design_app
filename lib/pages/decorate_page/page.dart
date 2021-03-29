import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class DecoratePage extends Page<DecorateState, Map<String, dynamic>>
    with TickerProviderMixin {
  DecoratePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<DecorateState>(
              adapter: null, slots: <String, Dependent<DecorateState>>{}),
          middleware: <Middleware<DecorateState>>[],
        );
}
