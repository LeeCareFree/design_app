import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PersonalListComponent extends Component<PersonalListState> {
  PersonalListComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PersonalListState>(
                adapter: null,
                slots: <String, Dependent<PersonalListState>>{
                }),);

}
