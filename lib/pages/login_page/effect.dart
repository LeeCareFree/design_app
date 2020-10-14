/*
 * @Author: your name
 * @Date: 2020-10-10 14:14:45
 * @LastEditTime: 2020-10-14 14:11:04
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\login_page\effect.dart
 */
import 'dart:convert';
import 'dart:async';
import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/login_model.dart';
import 'package:bluespace/models/user_info_entity.dart';
import 'package:bluespace/net/dio_utils.dart';
import 'package:bluespace/net/http_api.dart';
import 'package:bluespace/router/fluro_navigator.dart';
import 'package:bluespace/utils/common.dart';
import 'package:bluespace/utils/toast.dart';
import 'package:bluespace/utils/native_method.dart';
import 'package:bluespace/utils/progress.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'action.dart';
import 'state.dart';

Effect<LoginPageState> buildEffect() {
  return combineEffects(<Object, Effect<LoginPageState>>{
    LoginPageAction.action: _onAction,
    LoginPageAction.loginClicked: _onLoginClicked,
    LoginPageAction.getUserInfo: _getUserInfo,
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
  ctx.state.userFocusNode.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.submitAnimationController.dispose();
  ctx.state.userTextController.dispose();
  ctx.state.passwordTextController.dispose();
}

void _onAction(Action action, Context<LoginPageState> ctx) {}
Future _onLoginClicked(Action action, Context<LoginPageState> ctx) async {
  ctx.state.submitAnimationController.forward();
  if (ctx.state.isPhoneLogin)
    await _phoneNumSignIn(action, ctx);
  else
    await _phoneNumSignIn(action, ctx);
  // Navigator.of(ctx.context).pop({'s': true, 'name': 'lyc'});
}

Future _onWeixinSignin(Action action, Context<LoginPageState> ctx) async {
  print('微信登录');
}

Future _phoneNumSignIn(Action action, Context<LoginPageState> ctx) async {
  print('手机号登陆');
  // String cipherPhone = await encode(wrapWithTimestamps(ctx.state.user));
  // String cipherPwd = await encode(wrapWithTimestamps(ctx.state.pwd));
  // Map<String,dynamic> message = json.decode(action.payload);
  // showProgress(ctx.context);
  Map<String, String> params = Map();
  params['username'] = ctx.state.userTextController.text;
  params['password'] = ctx.state.passwordTextController.text;
  // params['vtoken'] = message['vtoken'];
  // params['vsessionId'] = message['vsessionId'];
  DioUtils.instance.requestNetwork<LoginModel>(Method.post, HttpApi.login,
      params: params, queryParameters: null, onSuccess: (res) async {
        ctx.dispatch(LoginPageActionCreator.getUserInfo());
    Toast.show('---------${res.msg}');
    ctx.state.submitAnimationController.stop();
  }, onError: (code, msg) {
    Toast.show(msg);
  });
  return null;
}

void _getUserInfo(Action action, Context<LoginPageState> ctx) async {
  println(ctx.state.user);
  // DioUtils.instance.requestNetwork<UserInfoEntity>(Method.get, HttpApi.getUserInfo,params: null,queryParameters: null,onSuccess: (data) async{
  //   GlobalStore.store.dispatch(GlobalActionCreator.updateUserInfo(data));
  //   NavigatorUtils.goBack(ctx.context);
  // },onError: (code,msg){
  //   Toast.show(msg);
  // });
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
