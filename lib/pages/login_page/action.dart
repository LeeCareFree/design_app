/*
 * @Author: your name
 * @Date: 2020-10-10 14:14:57
 * @LastEditTime: 2020-10-10 15:36:28
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\login_page\action.dart
 */
import 'package:fish_redux/fish_redux.dart';

enum LoginPageAction {
  action,
  loginClicked,
  getUserInfo,
  signUp,
  weixinSignin,
  switchLoginMode
}

class LoginPageActionCreator {
  static Action onAction() {
    return const Action(LoginPageAction.action);
  }

  static Action onLoginClicked() {
    return const Action(LoginPageAction.loginClicked);
  }
  static Action getUserInfo(){
    return const Action(LoginPageAction.getUserInfo);
  }
  static Action onSignUp() {
    return const Action(LoginPageAction.signUp);
  }

  static Action onWeixinSignIn() {
    return const Action(LoginPageAction.weixinSignin);
  }

  static Action switchLoginMode() {
    return const Action(LoginPageAction.switchLoginMode);
  }
}
