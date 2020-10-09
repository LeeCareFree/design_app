import 'package:fish_redux/fish_redux.dart';

class LikeState implements Cloneable<LikeState> {

  @override
  LikeState clone() {
    return LikeState();
  }
}

LikeState initState(Map<String, dynamic> args) {
  return LikeState();
}
