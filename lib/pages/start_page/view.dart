import 'dart:async';

import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/components/app_cliper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(StartState state, Dispatch dispatch, ViewService viewService) {
  return new Scaffold(
    resizeToAvoidBottomInset: false,
    body: state.type == 'againLogin'
        ? Stack(
            children: <Widget>[
              _BackGround(controller: state.animationController),
              _LoginBody(
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
          )
        : state.isLogin
            ? Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  new Container(
                    color: Colors.white,
                    child: new Image.network(
                      'http://8.129.214.128:3001/upload/publish/launch_image.jpg',
                      fit: BoxFit.cover,
                    ),
                    constraints: new BoxConstraints.expand(),
                  ),
                  new Container(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: new Container(
                          padding:
                              const EdgeInsets.only(top: 30.0, right: 20.0),
                          child: GestureDetector(
                            onTap: () =>
                                {dispatch(StartActionCreator.onJump())},
                            child: new Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(Adapt.width(20)),
                                    margin: EdgeInsets.fromLTRB(
                                        0, Adapt.height(20), 0, 0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            Adapt.radius(500))),
                                    child: Text(
                                      '跳过',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 13.5,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  _BackGround(controller: state.animationController),
                  _LoginBody(
                    passwordVisible: state.passwordVisible,
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
            radius: Adapt.radius(1000)),
        child: Container(
            height: headerHeight,
            width: Adapt.screenW(),
            decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black12, BlendMode.color),
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        'http://8.129.214.128:3001/upload/publish/launch_image.jpg'))),
            alignment: Alignment.center,
            child: Container(
              // color: Color.fromRGBO(20, 20, 20, 0.8),
              alignment: Alignment.center,
              height: headerHeight,
              width: Adapt.screenW(),
              // child: SlideTransition(
              //     position: Tween(begin: Offset(0, -1), end: Offset.zero)
              //         .animate(CurvedAnimation(
              //       parent: controller,
              //       curve: Interval(
              //         0.0,
              //         0.4,
              //         curve: Curves.ease,
              //       ),
              //     )),
              //     child: Image.asset(
              //       'assets/images/logo.png',
              //       width: Adapt.height(150),
              //       height: Adapt.width(150),
              //       color: Colors.blueGrey,
              //     )),
            )),
      ),
      Expanded(child: SizedBox()),
      Container(
          height: Adapt.height(200),
          width: Adapt.screenW(),
          padding: EdgeInsets.only(bottom: Adapt.height(20)),
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
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  final AnimationController submitAnimationController;
  final TextEditingController passwordTextController;
  final TextEditingController userTextController;
  final FocusNode userFocusNode;
  final FocusNode pwdFocusNode;
  final bool isPhoneLogin;
  final bool passwordVisible;
  const _LoginBody({
    this.dispatch,
    this.passwordVisible,
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
                      dispatch: dispatch,
                      onSubmit: (s) =>
                          dispatch(StartActionCreator.onLoginClicked()),
                      controller: animationController,
                      passwordVisible: passwordVisible,
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
                          dispatch(StartActionCreator.onLoginClicked()),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(Adapt.width(50),
                        Adapt.height(20), Adapt.width(50), Adapt.height(20)),
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
                          onTap: () => dispatch(StartActionCreator.onSignUp()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '注册一个账户',
                                style: TextStyle(
                                    color: Colors.grey, fontSize: Adapt.sp(32)),
                              ),
                              Icon(Icons.arrow_right)
                            ],
                          )),
                    )),
                // Container(
                //   alignment: Alignment.bottomCenter,
                //   height: Adapt.height(120),
                //   child: FadeTransition(
                //     opacity:
                //         Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                //       parent: animationController,
                //       curve: Interval(
                //         0.7,
                //         1.0,
                //         curve: Curves.ease,
                //       ),
                //     )),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: <Widget>[
                //         InkWell(
                //           onTap: () =>
                //               dispatch(StartActionCreator.switchLoginMode()),
                //           child: Image.asset(
                //             isPhoneLogin
                //                 ? 'assets/images/email_login.png'
                //                 : 'assets/images/phone_login.png',
                //             width: Adapt.width(50),
                //           ),
                //         ),
                //         SizedBox(
                //           width: Adapt.width(20),
                //         ),
                //         InkWell(
                //           onTap: () =>
                //               dispatch(StartActionCreator.onWeixinSignIn()),
                //           child: Image.asset(
                //             'assets/images/weixin_login.png',
                //             width: Adapt.width(50),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
  final bool passwordVisible;
  final Dispatch dispatch;
  const _PhoneNumberEntry(
      {this.controller,
      this.dispatch,
      this.passwordVisible,
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
              padding: EdgeInsets.all(Adapt.height(40)),
              child: TextField(
                focusNode: userFocusNode,
                controller: userTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: Adapt.height(28)),
                cursorColor: _theme.iconTheme.color,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: '请输入手机号',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    prefixStyle: TextStyle(fontSize: Adapt.sp(35)),
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
            padding: EdgeInsets.all(Adapt.height(40)),
            child: TextField(
              focusNode: pwdFocusNode,
              controller: passwordTextController,
              style: TextStyle(fontSize: Adapt.height(28)),
              cursorColor: _theme.iconTheme.color,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: '请输入密码',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: Icon(
                        //根据passwordVisible状态显示不同的图标
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: passwordVisible ? Colors.black : Colors.grey),
                    onPressed: () {
                      dispatch(StartActionCreator.setPasswordVisible());
                      //更新状态控制密码显示或隐藏
                    },
                  ),
                  prefixStyle: TextStyle(fontSize: Adapt.sp(35)),
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
          margin: EdgeInsets.only(top: Adapt.height(60)),
          height: Adapt.height(100),
          child: Stack(
            children: <Widget>[
              Container(
                height: Adapt.height(100),
                width: Tween<double>(begin: buttonWidth, end: Adapt.width(100))
                    .animate(submitWidth)
                    .value,
                child: FlatButton(
                  color: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
                  child: Text('登录',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.sp(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: onSubimt,
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(loadCurved),
                child: Container(
                  width: Adapt.width(100),
                  height: Adapt.width(100),
                  padding: EdgeInsets.all(Adapt.height(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
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
