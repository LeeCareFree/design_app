import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class CreatePage extends Page<CreateState, Map<String, dynamic>> {
  CreatePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<CreateState>(
                adapter: null,
                slots: <String, Dependent<CreateState>>{
                }),
            middleware: <Middleware<CreateState>>[
            ],);

}
