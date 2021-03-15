import 'dart:convert';
import 'dart:async';
import 'package:bluespace/globalState/action.dart';
import 'package:bluespace/globalState/store.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/router/routes.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'action.dart';
import 'state.dart';

Effect<StartState> buildEffect() {
  return combineEffects(<Object, Effect<StartState>>{
    StartAction.action: _onAction,
    StartAction.loginClicked: _onLoginClicked,
    StartAction.getUserInfo: _getUserInfo,
    StartAction.signUp: _onSignUp,
    StartAction.weixinSignin: _onWeixinSignin,
    StartAction.onJump: _onJump,
    Lifecycle.initState: _onInit,
    Lifecycle.build: _onBuild,
    Lifecycle.dispose: _onDispose
  });
}

void _onAction(Action action, Context<StartState> ctx) {}
void _onJump(Action action, Context<StartState> ctx) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  print(token);
  if (token != '') {
    var data = await DioUtil.request('token');
    data = json.decode(data.toString());
    print(data);
    if (data['code'] != 200) {
      StartActionCreator.onCheckIsLogin(false);
      Fluttertoast.showToast(msg: data['msg'] ?? '请登录！');
    } else {
      Fluttertoast.showToast(msg: data['msg'] ?? '登录成功！');
      Future.delayed(Duration(seconds: 3), () => _pushToMainPage(ctx.context));
    }
  } else {
    print(ctx.state.isLogin);
    Future.delayed(Duration(seconds: 0),
        () => ctx.dispatch(StartActionCreator.onCheckIsLogin(false)));
    print(ctx.state.isLogin);
    Fluttertoast.showToast(msg: '请登录！');
  }
}

Future _onBuild(Action action, Context<StartState> ctx) async {
  Future.delayed(
      Duration(milliseconds: 0), () => ctx.state.animationController.forward());
}

Future _pushToMainPage(BuildContext context) async {
  await Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (_, __, ___) {
        return Routes.routes.buildPage('mainPage', {
          'pages': List<Widget>.unmodifiable([
            Routes.routes.buildPage('homePage', null),
            Routes.routes.buildPage('articleDetailPage', null),
            Routes.routes.buildPage('createPage', null),
            Routes.routes.buildPage('likePage', null),
            Routes.routes.buildPage('minePage', null)
          ])
        });
      },
      settings: RouteSettings(name: 'mainPage')));
}

void _onInit(Action action, Context<StartState> ctx) async {
  ctx.state.pageController = PageController();
  ctx.state.userFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  ctx.state.isPhoneLogin = true;
  final Object ticker = ctx.stfState;
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.userTextController = TextEditingController();
  ctx.state.passwordTextController = TextEditingController();
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  if (token != '') {
    var data = await DioUtil.request('token');
    data = json.decode(data.toString());
    print(data);
    if (data['code'] != 200) {
      StartActionCreator.onCheckIsLogin(false);
      Fluttertoast.showToast(msg: data['msg'] ?? '请登录！');
    } else {
      Fluttertoast.showToast(msg: data['msg'] ?? '登录成功！');
      Future.delayed(Duration(seconds: 3), () => _pushToMainPage(ctx.context));
    }
  } else {
    print(ctx.state.isLogin);
    Future.delayed(Duration(seconds: 3),
        () => ctx.dispatch(StartActionCreator.onCheckIsLogin(false)));
    print(ctx.state.isLogin);
    Fluttertoast.showToast(msg: '请登录！');
  }
}

void _onDispose(Action action, Context<StartState> ctx) {
  ctx.state.animationController.dispose();
  ctx.state.userFocusNode.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.submitAnimationController.dispose();
  ctx.state.userTextController.dispose();
  ctx.state.passwordTextController.dispose();
  ctx.state.pageController.dispose();
}

Future _onLoginClicked(Action action, Context<StartState> ctx) async {
  ctx.state.submitAnimationController.forward();
  if (ctx.state.isPhoneLogin)
    await _phoneNumSignIn(action, ctx);
  else
    await _phoneNumSignIn(action, ctx);
}

Future _onWeixinSignin(Action action, Context<StartState> ctx) async {
  print('微信登录');
}

// 检查手机号和密码格式
bool isPhone(String str) {
  return new RegExp(
          '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(str);
}

bool isPwd(String str) {
  return new RegExp('^(?![0-9]+\$)(?![a-zA-Z]+\$)[0-9A-Za-z]{6,20}\$')
      .hasMatch(str);
}

Future _phoneNumSignIn(Action action, Context<StartState> ctx) async {
  print('手机号登录');
  // String cipherPhone = await encode(wrapWithTimestamps(ctx.state.user));
  // String cipherPwd = await encode(wrapWithTimestamps(ctx.state.pwd));
  // Map<String,dynamic> message = json.decode(action.payload);
  // showProgress(ctx.context);
  String username = ctx.state.userTextController.text;
  String password = ctx.state.passwordTextController.text;
  if (username.isEmpty ||
      !isPhone(username) ||
      password.isEmpty ||
      !isPwd(password)) {
    ctx.state.submitAnimationController.reset();
    Fluttertoast.showToast(msg: '请输入正确的手机号和密码！');
    return;
  }

  var loginData = {
    'username': username,
    'password': password,
  };
  String formData = json.encode(loginData);

  var data = await DioUtil.request('login', formData: formData);
  data = json.decode(data.toString());
  if (data['code'] != 200) {
    Fluttertoast.showToast(msg: data['msg'] ?? '请稍后再试！');
    ctx.state.submitAnimationController.reset();
  } else {
    ctx.state.submitAnimationController.reset();
    GlobalStore.store.dispatch(GlobalActionCreator.setUser(UserInfo(
        username: data['data']['username'],
        token: data['data']['token'],
        uid: data['data']['uid'])));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // token储存到本地
    final setTokenResult =
        await prefs.setString('token', data['data']['token']);
    await prefs.setString('username', data['data']['username']);
    await prefs.setString('uid', data['data']['uid']);
    await prefs.setString('avatar', data['data']['avatar']);
    if (setTokenResult) {
      debugPrint('保存登录token成功');
      ctx.state.submitAnimationController.reset();
      Future.delayed(
          Duration(milliseconds: 0), () => _pushToMainPage(ctx.context));
      Fluttertoast.showToast(msg: data['msg']);
    } else {
      ctx.state.submitAnimationController.reset();
      debugPrint('error, 保存登录token失败');
    }
  }
}

void _getUserInfo(Action action, Context<StartState> ctx) async {
  println(ctx.state.user);
  // DioUtils.instance.requestNetwork<UserInfoEntity>(Method.get, HttpApi.getUserInfo,params: null,queryParameters: null,onSuccess: (data) async{
  //   GlobalStore.store.dispatch(GlobalActionCreator.updateUserInfo(data));
  //   NavigatorUtils.goBack(ctx.context);
  // },onError: (code,msg){
  //   Toast.show(msg);
  // });
}

Future _onSignUp(Action action, Context<StartState> ctx) async {
  print('注册');
  String username = ctx.state.userTextController.text;
  String password = ctx.state.passwordTextController.text;
  if (username.isEmpty ||
      !isPhone(username) ||
      password.isEmpty ||
      !isPwd(password)) {
    ctx.state.submitAnimationController.reset();
    Fluttertoast.showToast(msg: '请输入正确的手机号和密码！');
    return;
  }
  Map<String, String> params = Map();
  params['username'] = username;
  params['password'] = password;
  // params['vtoken'] = message['vtoken'];
  // params['vsessionId'] = message['vsessionId'];
  var data = await DioUtil.request('register', formData: params);
  print(data);
  // DioUtils.instance.requestNetwork<LoginModel>(Method.post, HttpApi.register,
  //     params: params, queryParameters: null, onSuccess: (res) async {
  //   if (res.data != null) {
  //     ctx.dispatch(LoginPageActionCreator.getUserInfo());
  //     Navigator.of(ctx.context).pop({'s': true, 'name': res.data.username});
  //     ctx.state.submitAnimationController.reset();
  //     Toast.show(res.msg);
  //   }
  //   Toast.show(res.msg);
  // }, onError: (code, msg) {
  //   Toast.show(msg);
  // });
  return null;
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
}
