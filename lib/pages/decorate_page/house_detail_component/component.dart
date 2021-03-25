import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HouseDetailComponent extends Component<HouseDetailState> {
  HouseDetailComponent()
      : super(
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<HouseDetailState>(
              adapter: null, slots: <String, Dependent<HouseDetailState>>{}),
        );
}
