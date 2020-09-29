import 'package:bule_space/models/index/pageComponent.dart';
import 'package:bule_space/pages/home_page/page.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Action hide Page;



class Routes{
  // 登录页
  static String loginPage = '/loginPage';
  // 注册页
  static String logonPage = '/logonPage';
  // 首页
  static String homePage = '/homePage';
  // 设置页
  static String settingPage = '/settingPage';
  static List<dynamic> listRoutes = [];
  static void configureRoutes(Route router){
    // 跳转错误返回页

    listRoutes.add(PageComponent(pageName: Routes.homePage, page: HomePage()));
  }
  
}