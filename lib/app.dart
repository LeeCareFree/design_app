/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:56
 * @LastEditTime: 2021-03-10 14:19:23
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\app.dart
 */
import 'dart:convert';

import 'package:bluespace/net/service_method.dart';
import 'package:bluespace/router/routes.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    return MaterialApp(
      title: 'blueSpace',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      home: routes.buildPage('startPage', null),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute<Object>(builder: (BuildContext context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      },
    );
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
