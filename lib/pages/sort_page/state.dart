import 'package:fish_redux/fish_redux.dart';

class SortState implements Cloneable<SortState> {

  @override
  SortState clone() {
    return SortState();
  }
}

SortState initState(Map<String, dynamic> args) {
  return SortState();
}
