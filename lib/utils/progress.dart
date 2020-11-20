/*
 * @Author: your name
 * @Date: 2020-10-12 14:49:17
 * @LastEditTime: 2020-10-12 16:07:20
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\utils\progress.dart
 */
import 'package:bluespace/router/fluro_navigator.dart';
import 'package:bluespace/style/colors.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/utils/imageUtil.dart';
import 'package:bluespace/components/load_image.dart';
import 'package:flutter/material.dart';

/// *@Description: 自定义进度展示对话框
bool _isShowDialog = false;

void showProgress(BuildContext context) async {
  if (!_isShowDialog) {
    _isShowDialog = true;
    await showGeneralDialog<bool>(
      context: context,
      barrierColor: Color(0x11000000),
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return Center(
              child: Container(
                width: Adapt.px(120),
                height: Adapt.px(120),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: ImageUtils.getAssetImage('ico_loading_bg'),
                      fit: BoxFit.fill),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: Adapt.px(25)),
                  child: Column(
                    children: <Widget>[
                      LoadImage(
                        'loading',
                        format: 'gif',
                        width: Adapt.px(100),
                        height: Adapt.px(40),
                      ),
                      Text(
                        '加载中...',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: Adapt.px(14),
                          color: MyColors.textGrayColor,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
    _isShowDialog = false;
  }
}

void hideProgress(BuildContext context) {
  if (_isShowDialog) {
    _isShowDialog = false;
    NavigatorUtils.goBack(context);
  }
}

Widget _buildMaterialDialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}
