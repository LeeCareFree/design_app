import 'package:flutter/material.dart';
import './toast.dart';

// 退出应用工具类
class ExitApp extends StatefulWidget{
  const ExitApp({
    Key key,
    @required this.child,
    this.duration: const Duration(milliseconds: 2000),
  }): super(key: key);
  // 子元素
  final Widget child;
  // 两次点击的时间间隔
  final Duration duration;

  @override
  _ExitApp createState()=> _ExitApp();
}

class _ExitApp extends State<ExitApp>{
  DateTime _lastTime;
  @override
  Widget build(BuildContext context) {
    // 返回拦截 用于二次确认退出的场景
    return WillPopScope(
      // 子组件
      child: widget.child,
      // 返回回调
      onWillPop: _isExit,
    );
  }
  Future<bool> _isExit(){
    if(_lastTime == null || DateTime.now().difference(_lastTime) > widget.duration){
      _lastTime = DateTime.now();
      Toast.show("再次点击退出应用");
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }
}