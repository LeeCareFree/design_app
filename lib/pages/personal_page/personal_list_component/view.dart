import 'package:bluespace/components/backdrop.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalListState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  final _tabs = ['风神传', '封妖志', "幻将录", "永恒传说"];
  return SliverToBoxAdapter(
      child: Container(
    // height: Adapt.height(2000),
    color: Colors.red,
    // child:
    // child: NestedScrollView(
    //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //     return <Widget>[
    //       SliverOverlapAbsorber(
    //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    //         sliver: SliverAppBar(
    //           title: const Text('旷古奇书'),
    //           pinned: true,
    //           elevation: 6, //影深
    //           expandedHeight: 220.0,
    //           forceElevated: innerBoxIsScrolled, //为true时展开有阴影
    //           flexibleSpace: FlexibleSpaceBar(
    //             background: Image.asset(
    //               "assets/images/wy_300x200_filter.webp",
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           bottom: TabBar(
    //             tabs: _tabs
    //                 .map((String name) => Tab(
    //                       text: name,
    //                     ))
    //                 .toList(),
    //           ),
    //         ),
    //       ),
    //     ];
    //   },
    //   // body: _buildTabBarView(),
    // ),
  ));
}
