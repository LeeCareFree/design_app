import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OrderComponent extends Component<OrderComponentState> {
  OrderComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OrderComponentState>(
              adapter: null, slots: <String, Dependent<OrderComponentState>>{}),
        );
}
