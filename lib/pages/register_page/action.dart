import 'package:fish_redux/fish_redux.dart';

enum RegisterPageAction {
  action,
  registerWithEmail,
  setPasswordVisible,
  setIsDesigner
}

class RegisterPageActionCreator {
  static Action onAction() {
    return const Action(RegisterPageAction.action);
  }

  static Action setIsDesigner() {
    return const Action(RegisterPageAction.setIsDesigner);
  }

  static Action setPasswordVisible(int type) {
    return Action(RegisterPageAction.setPasswordVisible, payload: type);
  }

  static Action onRegisterWithEmail() {
    return const Action(RegisterPageAction.registerWithEmail);
  }
}
