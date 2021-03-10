import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'view.dart';

class UserInfoComponent extends Component<UserInfoState> {
  UserInfoComponent()
      : super(
          shouldUpdate: (oldState, newState) {
            return oldState.name != newState.name;
          },
          view: buildView,
          dependencies: Dependencies<UserInfoState>(
              adapter: null, slots: <String, Dependent<UserInfoState>>{}),
        );
}
