import 'package:bluespace/pages/personal_page/state.dart';
import 'package:fish_redux/fish_redux.dart';

class PersonalListState implements Cloneable<PersonalListState> {
  @override
  PersonalListState clone() {
    return PersonalListState();
  }
}

class PersonalListConnector extends ConnOp<PersonalState, PersonalListState> {
  @override
  PersonalListState get(PersonalState state) {
    PersonalListState mstate = PersonalListState();
    // mstate.movie = state.movie;
    // mstate.tv = state.tv;
    // mstate.showHeaderMovie = state.showHeaderMovie;
    return mstate;
  }

  @override
  void set(PersonalState state, PersonalListState subState) {
    // state.showHeaderMovie = subState.showHeaderMovie;
  }
}
