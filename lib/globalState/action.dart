import 'package:bluespace/models/user_info_entity.dart';
import 'package:fish_redux/fish_redux.dart';
enum GlobalAction {changeThemeColor,setUser,setUserMember}

class GlobalActionCreator{
  static Action onChangeThemeColor(){
    return const Action(GlobalAction.changeThemeColor);
  }
  static Action setUser(UserInfoEntity userInfo) {
    return Action(GlobalAction.setUser, payload: userInfo);
  }
}