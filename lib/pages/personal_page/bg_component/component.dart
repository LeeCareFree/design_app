import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class BgComponent extends Component<BgState> {
  BgComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<BgState>(
                adapter: null,
                slots: <String, Dependent<BgState>>{
                }),);

}
