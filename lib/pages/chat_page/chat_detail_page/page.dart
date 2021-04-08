import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChatDetailPage extends Page<ChatDetailState, Map<String, dynamic>> {
  ChatDetailPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChatDetailState>(
                adapter: null,
                slots: <String, Dependent<ChatDetailState>>{
                }),
            middleware: <Middleware<ChatDetailState>>[
            ],);

}
