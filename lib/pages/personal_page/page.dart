import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PersonalPage extends Page<PersonalState, Map<String, dynamic>>
    with TickerProviderMixin {
  PersonalPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<PersonalState>(
              adapter: null, slots: <String, Dependent<PersonalState>>{}),
          middleware: <Middleware<PersonalState>>[],
        );
}
