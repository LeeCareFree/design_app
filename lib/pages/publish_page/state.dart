import 'package:fish_redux/fish_redux.dart';

class PublishState implements Cloneable<PublishState> {

  @override
  PublishState clone() {
    return PublishState();
  }
}

PublishState initState(Map<String, dynamic> args) {
  return PublishState();
}
