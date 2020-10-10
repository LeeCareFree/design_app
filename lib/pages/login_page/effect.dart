/*
 * @Author: your name
 * @Date: 2020-10-10 14:14:45
 * @LastEditTime: 2020-10-10 18:30:22
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\login_page\effect.dart
 */
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'action.dart';
import 'state.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    LoginPageAction.action: _onAction,
    LoginPageAction.loginClicked: _onLoginClicked,
    LoginPageAction.signUp: _onSignUp,
    LoginPageAction.weixinSignin: _onWeixinSignin,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

void _onInit(Action action, Context<LoginPageState> ctx) {
  ctx.state.isPhoneLogin = true;
  TickerProvider ticker = ctx.stfState as TickerProvider;
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.userTextController = TextEditingController();
  ctx.state.passwordTextController = TextEditingController();
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 2000));
}

void _onBuild(Action action, Context<LoginPageState> ctx) {
  Future.delayed(Duration(milliseconds: 150),
      () => ctx.state.animationController.forward());
}

void _onDispose(Action action, Context<LoginPageState> ctx) {
  ctx.state.animationController.dispose();
  // ctx.state.userFocusNode.dispose();
  // ctx.state.pwdFocusNode.dispose();
  ctx.state.submitAnimationController.dispose();
  // ctx.state.userTextController.dispose();
  // ctx.state.passwordTextController.dispose();
}

void _onAction(Action action, Context<LoginPageState> ctx) {}
Future _onLoginClicked(Action action, Context<LoginPageState> ctx) async {
  ctx.state.submitAnimationController.forward();
  if (ctx.state.isPhoneLogin)
    await _phoneNumSignIn(action, ctx);
  else
    await _phoneNumSignIn(action, ctx);
  print('----------------${ctx.state.userTextController.text}');
  print('----------------${ctx.state.passwordTextController.text}');
  Navigator.of(ctx.context).pop({'s': true, 'name': 'lyc'});
}

Future _onWeixinSignin(
    Action action, Context<LoginPageState> ctx) async {
      print('微信登录');
}

Future _phoneNumSignIn(
    Action action, Context<LoginPageState> ctx) async {
    print('手机号登陆');

  return null;
}

Future _onSignUp(Action action, Context<LoginPageState> ctx) async {
  // Navigator.of(ctx.context)
  //     .push(PageRouteBuilder(pageBuilder: (context, an, _) {
  //   return FadeTransition(
  //     opacity: an,
  //     child: RegisterPage().buildPage(null),
  //   );
  // })).then((results) {
  //   if (results is PopWithResults) {
  //     PopWithResults popResult = results;
  //     if (popResult.toPage == 'mainpage')
  //       Navigator.of(ctx.context).pop(results.results);
  //   }
  // });
  print('注册');
}
