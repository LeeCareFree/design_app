import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HomeSwiperComponent extends Component<HomeSwiperState> {
  HomeSwiperComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HomeSwiperState>(
                adapter: null,
                slots: <String, Dependent<HomeSwiperState>>{
                }),);

}
