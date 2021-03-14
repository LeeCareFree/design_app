/*
 * @Author: your name
 * @Date: 2020-10-09 16:48:12
 * @LastEditTime: 2020-10-14 10:39:36
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\utils\exitApp.dart
 */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration: const Duration(milliseconds: 2500),
  }) : super(key: key);

  final Widget child;

  /// 两次点击返回按钮的时间间隔
  final Duration duration;

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Fluttertoast.showToast(msg: '再次点击退出应用');
      return Future.value(false);
    }
    return Future.value(true);
  }
}
