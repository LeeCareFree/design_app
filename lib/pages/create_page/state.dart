import 'package:fish_redux/fish_redux.dart';

class CreateState implements Cloneable<CreateState> {

  @override
  CreateState clone() {
    return CreateState();
  }
}

CreateState initState(Map<String, dynamic> args) {
  return CreateState();
}
