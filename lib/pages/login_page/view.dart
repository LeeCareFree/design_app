import 'dart:async';

import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/utils/toast.dart';
import 'package:bluespace/components/app_cliper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    LoginPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _LoginFrom(
          animationController: state.animationController,
          submitAnimationController: state.submitAnimationController,
          isPhoneLogin: state.isPhoneLogin,
          userFocusNode: state.userFocusNode,
          pwdFocusNode: state.pwdFocusNode,
          userTextController: state.userTextController,
          passwordTextController: state.passwordTextController,
          dispatch: dispatch,
        ),
        _AppBar(),
      ],
    ),
  );
}

class _BackGround extends StatelessWidget {
  final AnimationController controller;
  const _BackGround({this.controller});
  @override
  Widget build(BuildContext context) {
    final double headerHeight = Adapt.screenH() / 3;
    return Column(children: [
      ClipPath(
        clipper: AppCliper(
            height: headerHeight,
            width: Adapt.screenW(),
            radius: Adapt.px(1000)),
        child: Container(
            height: headerHeight,
            width: Adapt.screenW(),
            decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black12, BlendMode.color),
                    fit: BoxFit.cover,
                    image: new ExactAssetImage('assets/images/login_bg.png'))),
            alignment: Alignment.center,
            child: Container(
              color: Color.fromRGBO(20, 20, 20, 0.8),
              alignment: Alignment.center,
              height: headerHeight,
              width: Adapt.screenW(),
              child: SlideTransition(
                  position: Tween(begin: Offset(0, -1), end: Offset.zero)
                      .animate(CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      0.0,
                      0.4,
                      curve: Curves.ease,
                    ),
                  )),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: Adapt.px(150),
                    height: Adapt.px(150),
                    color: Colors.blueGrey,
                  )),
            )),
      ),
      Expanded(child: SizedBox()),
      Container(
          height: Adapt.px(200),
          width: Adapt.screenW(),
          padding: EdgeInsets.only(bottom: Adapt.px(20)),
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: controller,
                  curve: Interval(
                    0.7,
                    1.0,
                    curve: Curves.ease,
                  ),
                )),
                child: Text('Powered by Lee')),
          )),
    ]);
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

class _LoginFrom extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  final AnimationController submitAnimationController;
  final TextEditingController passwordTextController;
  final TextEditingController userTextController;
  final FocusNode userFocusNode;
  final FocusNode pwdFocusNode;
  final bool isPhoneLogin;
  const _LoginFrom({
    this.dispatch,
    this.animationController,
    this.submitAnimationController,
    this.userTextController,
    this.userFocusNode,
    this.passwordTextController,
    this.pwdFocusNode,
    this.isPhoneLogin,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final cardCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0,
        0.4,
        curve: Curves.ease,
      ),
    );
    final submitCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.ease,
      ),
    );
    return Center(
      child: SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.screenH() / 2,
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: _PhoneNumberEntry(
                      onSubmit: (s) =>
                          dispatch(LoginPageActionCreator.onLoginClicked()),
                      controller: animationController,
                      userFocusNode: userFocusNode,
                      pwdFocusNode: pwdFocusNode,
                      userTextController: userTextController,
                      passwordTextController: passwordTextController,
                    )),
                SlideTransition(
                  position: Tween(begin: Offset(0, 1), end: Offset.zero)
                      .animate(submitCurve),
                  child: FadeTransition(
                    opacity: Tween(begin: 0.0, end: 1.0).animate(submitCurve),
                    child: _SubmitButton(
                      controller: submitAnimationController,
                      onSubimt: () =>
                          dispatch(LoginPageActionCreator.onLoginClicked()),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(
                        Adapt.px(50), Adapt.px(20), Adapt.px(50), Adapt.px(20)),
                    alignment: Alignment.center,
                    child: FadeTransition(
                      opacity:
                          Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval(
                          0.7,
                          1.0,
                          curve: Curves.ease,
                        ),
                      )),
                      child: GestureDetector(
                        onTap: () =>
                            dispatch(LoginPageActionCreator.onSignUp()),
                        child: Text(
                          '注册一个账户',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: Adapt.px(120),
                  child: FadeTransition(
                    opacity:
                        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval(
                        0.7,
                        1.0,
                        curve: Curves.ease,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () => dispatch(
                              LoginPageActionCreator.switchLoginMode()),
                          child: Image.asset(
                            isPhoneLogin
                                ? 'assets/images/email_login.png'
                                : 'assets/images/phone_login.png',
                            width: Adapt.px(50),
                          ),
                        ),
                        SizedBox(
                          width: Adapt.px(20),
                        ),
                        InkWell(
                          onTap: () =>
                              dispatch(LoginPageActionCreator.onWeixinSignIn()),
                          child: Image.asset(
                            'assets/images/weixin_login.png',
                            width: Adapt.px(50),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberEntry extends StatelessWidget {
  final AnimationController controller;
  final TextEditingController userTextController;
  final TextEditingController passwordTextController;
  final FocusNode userFocusNode;
  final FocusNode pwdFocusNode;
  final Function(String) onSubmit;
  const _PhoneNumberEntry(
      {this.controller,
      this.userTextController,
      this.userFocusNode,
      this.pwdFocusNode,
      this.passwordTextController,
      this.onSubmit});
  @override
  Widget build(BuildContext context) {
    final accountCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.ease,
      ),
    );
    final passwordCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.ease,
      ),
    );
    final _theme = ThemeStyle.getTheme(context);

    return Column(children: [
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(accountCurve),
        child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(accountCurve),
            child: Padding(
              padding: EdgeInsets.all(Adapt.px(40)),
              child: TextField(
                focusNode: userFocusNode,
                controller: userTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: Adapt.px(35)),
                cursorColor: _theme.iconTheme.color,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: '请输入手机号',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black87))),
                onSubmitted: (s) {
                  userFocusNode.nextFocus();
                },
              ),
            )),
      ),
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(passwordCurve),
        child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(passwordCurve),
          child: Padding(
            padding: EdgeInsets.all(Adapt.px(40)),
            child: TextField(
              focusNode: pwdFocusNode,
              controller: passwordTextController,
              style: TextStyle(fontSize: Adapt.px(35)),
              cursorColor: _theme.iconTheme.color,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: '请输入密码',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black87))),
              onSubmitted: onSubmit,
            ),
          ),
        ),
      ),
    ]);
  }
}

class _SubmitButton extends StatelessWidget {
  final AnimationController controller;
  final Function onSubimt;
  const _SubmitButton({this.controller, this.onSubimt});
  @override
  Widget build(BuildContext context) {
    final submitWidth = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    final loadCurved = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.ease,
      ),
    );
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, w) {
        double buttonWidth = Adapt.screenW() * 0.8;
        return Container(
          margin: EdgeInsets.only(top: Adapt.px(60)),
          height: Adapt.px(100),
          child: Stack(
            children: <Widget>[
              Container(
                height: Adapt.px(100),
                width: Tween<double>(begin: buttonWidth, end: Adapt.px(100))
                    .animate(submitWidth)
                    .value,
                child: FlatButton(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: Text('登录',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.px(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: onSubimt,
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(loadCurved),
                child: Container(
                  width: Adapt.px(100),
                  height: Adapt.px(100),
                  padding: EdgeInsets.all(Adapt.px(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
