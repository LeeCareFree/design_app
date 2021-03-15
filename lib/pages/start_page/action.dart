import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum StartAction {
  action,
  loginClicked,
  getUserInfo,
  signUp,
  weixinSignin,
  switchLoginMode,
  onJump,
  onCheckIsLogin
}

class StartActionCreator {
  static Action onAction() {
    return const Action(StartAction.action);
  }

  static Action onLoginClicked() {
    return const Action(StartAction.loginClicked);
  }

  static Action getUserInfo() {
    return const Action(StartAction.getUserInfo);
  }

  static Action onSignUp() {
    return const Action(StartAction.signUp);
  }

  static Action onWeixinSignIn() {
    return const Action(StartAction.weixinSignin);
  }

  static Action switchLoginMode() {
    return const Action(StartAction.switchLoginMode);
  }

  static Action onCheckIsLogin(bool isLogin) {
    return Action(StartAction.onCheckIsLogin, payload: isLogin);
  }

  static Action onJump() {
    return Action(StartAction.onJump);
  }
}
