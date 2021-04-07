import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FriendPage extends Page<FriendState, Map<String, dynamic>> {
  FriendPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FriendState>(
                adapter: null,
                slots: <String, Dependent<FriendState>>{
                }),
            middleware: <Middleware<FriendState>>[
            ],);

}
