import 'package:bluespace/components/app_cliper.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    RegisterPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        _Header(),
        _RegisterForm(
          dispatch: dispatch,
          passwordVisible: state.passwordVisible,
          passwordTwoVisible: state.passwordTwoVisible,
          isDesigner: state.isDesigner,
          animationController: state.animationController,
          nameTextController: state.nameTextController,
          nameFocusNode: state.nameFocusNode,
          passWordTextController: state.passWordTextController,
          pwdFocusNode: state.pwdFocusNode,
          passWordTwoTextController: state.passWordTwoTextController,
          pwdTwoFocusNode: state.pwdTwoFocusNode,
          submitAnimationController: state.submitAnimationController,
        ),
        _AppBar(),
      ],
    ),
  );
}

class _Header extends StatelessWidget {
  final double headerHeight = Adapt.screenH() / 3;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AppCliper(
          height: headerHeight,
          width: Adapt.screenW(),
          radius: Adapt.radius(1000)),
      child: Container(
        height: headerHeight,
        padding: EdgeInsets.only(bottom: Adapt.height(50)),
        width: Adapt.screenW(),
        decoration: BoxDecoration(
            color: Colors.black87,
            image: DecorationImage(
                // colorFilter: ColorFilter.mode(Colors.white, BlendMode.color),
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    'http://8.129.214.128:3001/upload/publish/launch_image.jpg'))),
        alignment: Alignment.center,
        // child: Container(
        //     // color: Color.fromRGBO(20, 20, 20, 0.8),
        //     alignment: Alignment.center,
        //     height: headerHeight,
        //     width: Adapt.screenW(),
        //     child: Image.asset(
        //       'assets/images/logo.png',
        //       width: Adapt.width(150),
        //       height: Adapt.height(150),
        //       color: Colors.white,
        //     )),
      ),
    );
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
          margin: EdgeInsets.only(top: Adapt.height(20)),
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
                  child: Text('注册',
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
                  height: Adapt.height(100),
                  padding: EdgeInsets.all(Adapt.width(20)),
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

class _RegisterForm extends StatelessWidget {
  final Dispatch dispatch;
  final bool passwordVisible;
  final bool passwordTwoVisible;
  final bool isDesigner;
  final TextEditingController nameTextController;
  final TextEditingController passWordTextController;
  final TextEditingController passWordTwoTextController;
  final AnimationController animationController;
  final FocusNode nameFocusNode;
  final FocusNode pwdFocusNode;
  final FocusNode pwdTwoFocusNode;
  final AnimationController submitAnimationController;
  const _RegisterForm(
      {this.dispatch,
      this.passwordTwoVisible,
      this.isDesigner,
      this.passwordVisible,
      this.pwdTwoFocusNode,
      this.passWordTwoTextController,
      this.animationController,
      this.nameFocusNode,
      this.nameTextController,
      this.passWordTextController,
      this.pwdFocusNode,
      this.submitAnimationController});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.screenH() / 2 + Adapt.height(100),
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(Adapt.width(40)),
                    child: TextFormField(
                      controller: nameTextController,
                      focusNode: nameFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.sp(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: '手机号',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          filled: true,
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.sp(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => nameFocusNode.nextFocus(),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.width(40)),
                    child: TextFormField(
                      obscureText: !passwordVisible,
                      controller: passWordTextController,
                      focusNode: pwdFocusNode,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.sp(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: '密码',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                                //根据passwordVisible状态显示不同的图标
                                passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: passwordVisible
                                    ? Colors.black
                                    : Colors.grey),
                            onPressed: () {
                              dispatch(
                                  RegisterPageActionCreator.setPasswordVisible(
                                      1));
                              //更新状态控制密码显示或隐藏
                            },
                          ),
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.sp(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => pwdFocusNode.nextFocus(),
                    )),
                Padding(
                    padding: EdgeInsets.all(Adapt.width(40)),
                    child: TextFormField(
                      obscureText: !passwordTwoVisible,
                      controller: passWordTwoTextController,
                      focusNode: pwdTwoFocusNode,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: Adapt.sp(35)),
                      decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          hintText: '确认密码',
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                                //根据passwordVisible状态显示不同的图标
                                passwordTwoVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: passwordTwoVisible
                                    ? Colors.black
                                    : Colors.grey),
                            onPressed: () {
                              dispatch(
                                  RegisterPageActionCreator.setPasswordVisible(
                                      2));
                              //更新状态控制密码显示或隐藏
                            },
                          ),
                          prefixStyle: TextStyle(
                              color: Colors.black, fontSize: Adapt.sp(35)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.black87))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => {
                        pwdFocusNode.unfocus(),
                        dispatch(
                            RegisterPageActionCreator.onRegisterWithEmail())
                      },
                    )),
                Row(
                  children: [
                    SizedBox(
                      width: Adapt.width(100),
                    ),
                    Text(
                      '是否设计师或装修公司',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: Adapt.width(80),
                    ),
                    Text(
                      isDesigner ? '是' : '否',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    CupertinoSwitch(
                      activeColor: Colors.black,
                      value: isDesigner,
                      onChanged: (bool value) {
                        dispatch(RegisterPageActionCreator.setIsDesigner());
                      },
                    )
                  ],
                ),
                _SubmitButton(
                    controller: submitAnimationController,
                    onSubimt: () => {
                          pwdFocusNode.unfocus(),
                          dispatch(
                              RegisterPageActionCreator.onRegisterWithEmail()),
                        }),
                SizedBox(
                  height: Adapt.height(20),
                ),
                GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '已有账号去登录',
                          style: TextStyle(
                              color: Colors.grey, fontSize: Adapt.sp(32)),
                        ),
                        Icon(Icons.arrow_right)
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
