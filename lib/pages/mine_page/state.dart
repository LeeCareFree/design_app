import 'package:fish_redux/fish_redux.dart';

class MineState implements Cloneable<MineState> {

  @override
  MineState clone() {
    return MineState();
  }
}

MineState initState(Map<String, dynamic> args) {
  return MineState();
}
