import 'package:bule_space/settings/colors.dart';
import 'package:bule_space/settings/dimens.dart';
import 'package:bule_space/utils/ExitApp.dart';
import 'package:bule_space/utils/themeColor.dart';
import 'package:bule_space/widgets/loadImage.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'action.dart';
import 'state.dart';

// 导航页
Widget buildView(IndexState state, Dispatch dispatch, ViewService viewService) {
  return ExitApp(
    child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ThemeUtils.getBackgroundColor(viewService.context),
          items: _buildBottomNavigationBarItem(),
          type: BottomNavigationBarType.fixed,
          currentIndex: state.currentIndex,
          elevation: 5.0,
          iconSize: 21.0,
          selectedFontSize: Dimens.font_sp10,
          unselectedFontSize: Dimens.font_sp10,
          selectedItemColor: MyColors.app_main,
          unselectedItemColor: MyColors.unselected_item_color,
          onTap: (index) {
            state.pageController.jumpToPage(index);
            dispatch(IndexActionCreator.jump(index));
          },
        ),
        body: PageView(
          controller: state.pageController,
          onPageChanged: (int index) {
            _onPageChange(index);
          },
          children: state.pageList,
          physics: NeverScrollableScrollPhysics(),
        )),
  );
}

void _onPageChange(int index) {}

List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
  List<String> _appBarTitles = ["首页", "搜索", "", "关注", "我的"];
  List<BottomNavigationBarItem> _list;
  if (_list == null) {
    var _tabImages = [
      [
        const LoadAssetImage("home", width: 25.0),
        const LoadAssetImage("home_active", width: 25.0),
      ],
      [
        const LoadAssetImage("home", width: 25.0),
        const LoadAssetImage("home_active", width: 25.0),
      ],
      [
        const LoadAssetImage("home", width: 25.0),
        const LoadAssetImage("home_active", width: 25.0),
      ],
      [
        const LoadAssetImage("home", width: 25.0),
        const LoadAssetImage("home_active", width: 25.0),
      ]
    ];
    _list = List.generate(4, (i) {
      return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
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
