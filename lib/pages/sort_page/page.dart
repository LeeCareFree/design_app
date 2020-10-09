import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SortPage extends Page<SortState, Map<String, dynamic>> {
  SortPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SortState>(
                adapter: null,
                slots: <String, Dependent<SortState>>{
                }),
            middleware: <Middleware<SortState>>[
            ],);

}
