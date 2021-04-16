import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MyhomeSettingPage extends Page<MyhomeSettingState, Map<String, dynamic>> {
  MyhomeSettingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MyhomeSettingState>(
                adapter: null,
                slots: <String, Dependent<MyhomeSettingState>>{
                }),
            middleware: <Middleware<MyhomeSettingState>>[
            ],);

}
