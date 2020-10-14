/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:56
 * @LastEditTime: 2020-10-14 10:52:41
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\app.dart
 */
import 'package:bluespace/router/routes.dart';
import 'package:flutter/material.dart' hide Action;

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';

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
    return OKToast(
      child: FlutterEasyLoading(
        child: MaterialApp(
          title: 'Movie',
          debugShowCheckedModeBanner: false,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          home: routes.buildPage('startPage', null),
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute<Object>(builder: (BuildContext context) {
              return routes.buildPage(settings.name, settings.arguments);
            });
          },
        ),
      ),
    );
  }
}
