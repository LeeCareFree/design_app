import 'dart:convert';

import 'package:bluespace/net/service_method.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart' hide Action;
import 'package:fluttertoast/fluttertoast.dart';
import 'action.dart';
import 'state.dart';

Effect<RegisterPageState> buildEffect() {
  return combineEffects(<Object, Effect<RegisterPageState>>{
    RegisterPageAction.action: _onAction,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
    RegisterPageAction.registerWithEmail: _onRegisterWithEmail
  });
}

void _onAction(Action action, Context<RegisterPageState> ctx) {}

void _onInit(Action action, Context<RegisterPageState> ctx) {
  ctx.state.nameFocusNode = FocusNode();
  ctx.state.pwdFocusNode = FocusNode();
  ctx.state.pwdTwoFocusNode = FocusNode();
  ctx.state.nameTextController = TextEditingController();
  ctx.state.passWordTextController = TextEditingController();
  ctx.state.passWordTwoTextController = TextEditingController();
  final Object ticker = ctx.stfState;
  ctx.state.submitAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  ctx.state.animationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
}

void _onDispose(Action action, Context<RegisterPageState> ctx) {
  ctx.state.nameFocusNode.dispose();
  ctx.state.passWordTextController.dispose();
  ctx.state.passWordTwoTextController.dispose();
  ctx.state.pwdFocusNode.dispose();
  ctx.state.pwdTwoFocusNode.dispose();
  ctx.state.nameTextController.dispose();
  ctx.state.submitAnimationController.dispose();
  ctx.state.animationController.dispose();
}

void _onRegisterWithEmail(Action action, Context<RegisterPageState> ctx) async {
  if (ctx.state.nameTextController.text == '' ||
      ctx.state.passWordTextController.text == '' ||
      ctx.state.passWordTwoTextController.text == '') {
    Fluttertoast.showToast(msg: '请输入完整的信息！');
  } else if (ctx.state.passWordTextController.text !=
      ctx.state.passWordTwoTextController.text) {
    Fluttertoast.showToast(msg: '两次密码输入不一致！');
  } else {
    try {
      ctx.state.submitAnimationController.forward();
      print("object");
      String username = ctx.state.nameTextController.text;
      String password = ctx.state.passWordTextController.text;
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
      params['identity'] = ctx.state.isDesigner ? 'stylist' : 'user';
      var data = await DioUtil.request('register', formData: params);
      data = json.decode(data.toString());
      if (data['code'] == 200) {
        Navigator.of(ctx.context).pop();
        Fluttertoast.showToast(msg: data['msg'] ?? '注册成功！');
      } else {
        ctx.state.submitAnimationController.reset();
        Fluttertoast.showToast(msg: data['msg'] ?? '注册失败！');
      }
    } on Exception catch (e) {
      ctx.state.submitAnimationController.reverse();
      Fluttertoast.showToast(msg: e.toString());
    }
  }
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
