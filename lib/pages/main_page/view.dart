import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/utils/exitApp.dart';
import 'package:bluespace/components/keepalive_widget.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MainPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      // Adapt.initContext(context);
      final pageController = PageController();
      final _lightTheme = ThemeData.light().copyWith(
          backgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(
              labelColor: Color(0XFF505050),
              unselectedLabelColor: Colors.grey));
      final _darkTheme = ThemeData.dark().copyWith(
          backgroundColor: Color(0xFF303030),
          tabBarTheme: TabBarTheme(
              labelColor: Colors.white, unselectedLabelColor: Colors.grey));
      final MediaQueryData _mediaQuery = MediaQuery.of(context);
      final ThemeData _theme =
          _mediaQuery.platformBrightness == Brightness.light
              ? _lightTheme
              : _darkTheme;
      Widget _buildPage(Widget page) {
        return KeepAliveWidget(page);
      }

      return DoubleTapBackExitApp(
          child: Scaffold(
        key: state.scaffoldKey,
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: state.pages.map(_buildPage).toList(),
          controller: pageController,
          onPageChanged: (int i) =>
              dispatch(MainPageActionCreator.onTabChanged(i)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _theme.backgroundColor,
          items: _buildBottomNavigationBarItem(),
          currentIndex: state.selectedIndex,
          selectedItemColor: _theme.tabBarTheme.labelColor,
          unselectedItemColor: _theme.tabBarTheme.unselectedLabelColor,
          onTap: (int index) {
            pageController.jumpToPage(index);
          },
          type: BottomNavigationBarType.fixed,
        ),
      ));
    },
  );
}

List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
  var _appBarTitles = ['首页', '分类', '发布', '好物', '我的'];
  List<BottomNavigationBarItem> _list;
  if (_list == null) {
    var _tabImages = [
      [
        Icons.home,
        Icons.home,
      ],
      [
        Icons.sort,
        Icons.sort,
      ],
      [
        Icons.add,
        Icons.add,
      ],
      [
        Icons.local_mall,
        Icons.local_mall,
      ],
      [
        Icons.account_circle,
        Icons.account_circle,
      ],
    ];
    _list = List.generate(5, (i) {
      return BottomNavigationBarItem(
          // backgroundColor: const Color(0xFFEDF6FD),
          icon: Icon(_tabImages[i][0]),
          activeIcon: Icon(_tabImages[i][1]),
          title: Padding(
            padding: const EdgeInsets.only(top: 1.5),
            child: Text(
              _appBarTitles[i],
              key: Key(_appBarTitles[i]),
            ),
          ));
    });
  }
  return _list;
}
