import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PublishPage extends Page<PublishState, Map<String, dynamic>> {
  PublishPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PublishState>(
                adapter: null,
                slots: <String, Dependent<PublishState>>{
                }),
            middleware: <Middleware<PublishState>>[
            ],);

}
