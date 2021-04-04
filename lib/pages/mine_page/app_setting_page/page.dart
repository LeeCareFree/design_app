import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class AppSettingPage extends Page<AppSettingState, Map<String, dynamic>> {
  AppSettingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<AppSettingState>(
                adapter: null,
                slots: <String, Dependent<AppSettingState>>{
                }),
            middleware: <Middleware<AppSettingState>>[
            ],);

}
