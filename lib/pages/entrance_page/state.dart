import 'package:fish_redux/fish_redux.dart';

class EntranceState implements Cloneable<EntranceState> {

  @override
  EntranceState clone() {
    return EntranceState();
  }
}

EntranceState initState(Map<String, dynamic> args) {
  return EntranceState();
}
