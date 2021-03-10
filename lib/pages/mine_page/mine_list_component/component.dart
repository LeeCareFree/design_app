import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class MineListComponent extends Component<MineListState> {
  MineListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<MineListState>(
                adapter: null,
                slots: <String, Dependent<MineListState>>{
                }),);

}
