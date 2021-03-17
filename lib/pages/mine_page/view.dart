/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:38
 * @LastEditTime: 2020-10-09 18:21:12
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\view.dart
 */
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../style/themeStyle.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(MineState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: const Color(0xFFEDF6FD),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.width(40)),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              // scrollDirection: Axis.horizontal,
              slivers: [
                viewService.buildComponent('userInfo'),
                _SecondPanel(
                    // userInfo: state.uid,
                    onTap: () => dispatch(MineActionCreator.showTip('这是提示'))),
                viewService.buildComponent('order'),
                viewService.buildComponent('mineList')
                // Text('111')
                // SliverToBoxAdapter(
                //     child: _TipPanel(
                //   show: state.showTip,
                //   tip: state.tip,
                //   autoClose: true,
                //   onChange: (show) => dispatch(AccountActionCreator.hideTip()),
                // )),
                // SliverToBoxAdapter(
                //   child: _TabBarPanel(
                //     currentIndex: state.selectedTabBarIndex,
                //     onTap: (index) =>
                //         dispatch(AccountActionCreator.onTabBarTap(index)),
                //   ),
                // ),
                // _FeaturesPanel(
                //   index: state.selectedTabBarIndex,
                //   dispatch: dispatch,
                //   viewService: viewService,
                // )
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _SecondPanel extends StatelessWidget {
  final Function onTap;
  const _SecondPanel({this.onTap});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 25),
          height: Adapt.height(220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('100',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.sp(24),
                        )),
                    SizedBox(height: 5),
                    Text('发布',
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.sp(28)))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('80',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.sp(24),
                        )),
                    SizedBox(height: 5),
                    Text('关注',
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.sp(28)))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('203',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.sp(24),
                        )),
                    SizedBox(height: 5),
                    Text('收藏',
                        style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.sp(28)))
                  ],
                ),
                IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: const Color(0xFFFFFFFF),
                      size: 30,
                    ),
                    onPressed: () =>
                        {Navigator.of(context).pushNamed('personalPage')})
              ]),
        ),
      ),
    );
  }
}
