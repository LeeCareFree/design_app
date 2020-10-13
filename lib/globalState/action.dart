import 'package:bluespace/models/user_info_entity.dart';
import 'package:fish_redux/fish_redux.dart';
enum GlobalAction {changeThemeColor,updateUserInfo,setUserMember}

class GlobalActionCreator{
  static Action onChangeThemeColor(){
    return const Action(GlobalAction.changeThemeColor);
  }
  static Action updateUserInfo(UserInfoEntity userInfo) {
    return Action(GlobalAction.updateUserInfo, payload: userInfo);
  }
}