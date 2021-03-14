import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class SwiperComponent extends Component<SwiperState> {
  SwiperComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<SwiperState>(
                adapter: null,
                slots: <String, Dependent<SwiperState>>{
                }),);

}
