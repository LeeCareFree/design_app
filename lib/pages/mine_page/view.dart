/*
 * @Author: your name
 * @Date: 2020-10-09 16:40:38
 * @LastEditTime: 2020-10-09 18:21:12
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\view.dart
 */
import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../style/themeStyle.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(MineState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return SmartRefresher(
      enablePullDown: true,
      controller: state.refreshController,
      onRefresh: () => {
            dispatch(MineActionCreator.refreshPage()),
          },
      child: Scaffold(
        // backgroundColor: const Color(0xFFEDF6FD),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.width(40)),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            // scrollDirection: Axis.horizontal,
            slivers: [
              viewService.buildComponent('userInfo'),
              _SecondPanel(
                  uid: state.uid,
                  accountInfo: state.accountInfo,
                  onTap: () => dispatch(MineActionCreator.toPersoanlPage())),
              viewService.buildComponent('order'),
              viewService.buildComponent('mineList')
            ],
          ),
        ),
      ));
}

class _SecondPanel extends StatelessWidget {
  final Function onTap;
  final AccountInfo accountInfo;
  final String uid;
  const _SecondPanel({this.onTap, this.accountInfo, this.uid});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: Adapt.height(20)),
          height: Adapt.height(180),
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
                    Text(
                        accountInfo?.proNum.toString() == 'null'
                            ? '-'
                            : accountInfo?.proNum.toString(),
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
                    Text(
                        accountInfo?.followNum.toString() == 'null'
                            ? '-'
                            : accountInfo?.followNum.toString(),
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
                    Text(
                        accountInfo?.collNum.toString() == 'null'
                            ? '-'
                            : accountInfo?.collNum.toString(),
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
                    onPressed: onTap)
              ]),
        ),
      ),
    );
  }
}
