import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class UserInfoPage extends Page<UserInfoState, Map<String, dynamic>> {
  UserInfoPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<UserInfoState>(
                adapter: null,
                slots: <String, Dependent<UserInfoState>>{
                }),
            middleware: <Middleware<UserInfoState>>[
            ],);

}
