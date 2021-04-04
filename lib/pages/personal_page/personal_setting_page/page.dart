import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PersonalSettingPage extends Page<PersonalSettingState, Map<String, dynamic>> {
  PersonalSettingPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PersonalSettingState>(
                adapter: null,
                slots: <String, Dependent<PersonalSettingState>>{
                }),
            middleware: <Middleware<PersonalSettingState>>[
            ],);

}
