import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

// Toast工具类
class Toast{
  static show(String msg,{duration: 2000}){
    if(msg == null){
      return;
    }
    showToast(
      msg,
      duration: Duration(milliseconds: duration),
      // 每次当你显示新的 toast 时,旧的就会被关闭
      dismissOtherToast: true,
      backgroundColor: Color.fromARGB(140, 0, 0, 0),
      position: ToastPosition.bottom,
      radius: 20
      );
  }
  static cancelToast(){
    dismissAllToast();
  }
}