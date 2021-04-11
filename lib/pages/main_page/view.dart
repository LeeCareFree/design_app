import 'package:badges/badges.dart';
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
          items: _buildBottomNavigationBarItem(state),
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

List<BottomNavigationBarItem> _buildBottomNavigationBarItem(
    MainPageState state) {
  var _appBarTitles = ['首页', '装修', '发布', '消息', '我的'];
  List<BottomNavigationBarItem> _list;
  if (_list == null) {
    var _tabImages = [
      [
        Icons.home,
        Icons.home,
      ],
      [
        Icons.person_search_outlined,
        Icons.person_search_outlined,
      ],
      [
        Icons.add,
        Icons.add,
      ],
      [
        Icons.sms_outlined,
        Icons.sms_outlined,
      ],
      [
        Icons.account_circle,
        Icons.account_circle,
      ],
    ];
    _list = List.generate(5, (i) {
      if (i == 3 &&
          state.messageList?.sum != 0 &&
          state.messageList?.sum != null) {
        return BottomNavigationBarItem(
            // backgroundColor: const Color(0xFFEDF6FD),
            icon: Badge(
              badgeContent: Text(
                state.messageList.sum.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Adapt.sp(24)),
              ),
              child: Icon(_tabImages[3][0]),
            ),
            activeIcon: Badge(
              badgeContent: Text(
                state.messageList.sum.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: Adapt.sp(24)),
              ),
              child: Icon(_tabImages[3][0]),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(
                _appBarTitles[3],
                key: Key(_appBarTitles[3]),
              ),
            ));
      }
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
