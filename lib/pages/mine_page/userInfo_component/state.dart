import 'package:fish_redux/fish_redux.dart';

class UserInfoState implements Cloneable<UserInfoState> {

  @override
  UserInfoState clone() {
    return UserInfoState();
  }
}

UserInfoState initState(Map<String, dynamic> args) {
  return UserInfoState();
}
