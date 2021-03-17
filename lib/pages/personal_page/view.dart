import 'package:bluespace/components/backdrop.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      final _tabs = ['笔记', '收藏', "赞过"];
      return Scaffold(
        body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverAppBar(
                    shadowColor: Colors.white,
                    // title: const Text('旷古奇书'),
                    backgroundColor: _theme.bottomAppBarColor,
                    pinned: true,
                    elevation: 6, //影深
                    expandedHeight: 220.0,
                    forceElevated: innerBoxIsScrolled, //为true时展开有阴影
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        "http://192.168.0.105:3000/upload/publish/1.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    bottom: TabBar(
                      labelColor: Colors.black,
                      tabs: _tabs
                          .map((String name) => Tab(
                                text: name,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tabs.map((String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      return CustomScrollView(
                        key: PageStorageKey<String>(name),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                                    context),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.all(8.0),
                            sliver: SliverFixedExtentList(
                              itemExtent: 48.0,
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text('《$name》 第 $index章'),
                                  );
                                },
                                childCount: 50,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    },
  );
}
