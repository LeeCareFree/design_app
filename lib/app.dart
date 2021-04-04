/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:56
 * @LastEditTime: 2021-03-26 11:37:49
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\app.dart
 */
import 'dart:convert';

import 'package:bluespace/components/gifRefresh.dart';
import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/router/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AbstractRoutes routes = Routes.routes;
  final ThemeData _lightTheme = ThemeData.light();
  final ThemeData _darkTheme = ThemeData.dark();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(750, 1334),
        allowFontScaling: true,
        builder: () => GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus.unfocus();
              }
            },
            child: RefreshConfiguration(
                headerBuilder: () =>
                    GifHeader1(), // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
                footerBuilder: () => GifFooter1(), // 配置默认底部指示器
                headerTriggerDistance: 60.0, // 头部触发刷新的越界距离
                springDescription: SpringDescription(
                    stiffness: 170,
                    damping: 16,
                    mass: 1.9), // 自定义回弹动画,三个属性值意义请查询flutter api
                maxOverScrollExtent: 80, //头部最大可以拖动的范围,如果发生冲出视图范围区域,请设置这个属性
                maxUnderScrollExtent: 30, // 底部最大可以拖动的范围
                enableScrollWhenRefreshCompleted:
                    true, //这个属性不兼容PageView和TabBarView,如果你特别需要TabBarView左右滑动,你需要把它设置为true
                enableLoadingWhenFailed: true, //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
                hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
                enableBallisticLoad: true, // 可以通过惯性滑动触发加载更多
                child: MaterialApp(
                  title: 'Homi',
                  debugShowCheckedModeBanner: false,
                  theme: _lightTheme,
                  darkTheme: _darkTheme,
                  home: routes.buildPage('startPage', null),
                  onGenerateRoute: (RouteSettings settings) {
                    return MaterialPageRoute<Object>(
                        builder: (BuildContext context) {
                      return routes.buildPage(
                          settings.name, settings.arguments);
                    });
                  },
                ))));
  }
}

// class _AppState extends State<App> {
//   final AbstractRoutes routes = Routes.routes;
//   final ThemeData _lightTheme = ThemeData.light();
//   final ThemeData _darkTheme = ThemeData.dark();

//   @override
//   Widget build(BuildContext context) {
//     return OKToast(
//       child: FlutterEasyLoading(
//           child: ScreenUtilInit(
//         designSize: Size(750, 1334),
//         allowFontScaling: false,
//         builder: () => MaterialApp(
//           title: 'blueSpace',
//           debugShowCheckedModeBanner: false,
//           theme: _lightTheme,
//           darkTheme: _darkTheme,
//           home: routes.buildPage('startPage', null),
//           onGenerateRoute: (RouteSettings settings) {
//             return MaterialPageRoute<Object>(builder: (BuildContext context) {
//               return routes.buildPage(settings.name, settings.arguments);
//             });
//           },
//         ),
//       )),
//     );
//   }
// }
