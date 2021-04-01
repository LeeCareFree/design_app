import 'package:bluespace/components/article_list.dart';
import 'package:bluespace/components/backdrop.dart';
import 'package:bluespace/components/loading.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      // bool _showTitle = state.scrollController.hasClients &&
      //     state.scrollController.offset > Adapt.height(350) - Adapt.height(300);
      return Scaffold(
        body: Stack(children: [
          state.isLoading
              ? LoadingLayout(
                  title: '加载中...',
                  show: true,
                )
              : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: state.refreshController,
                  onRefresh: () => {
                        dispatch(PersonalActionCreator.getAccountInfo()),
                      },
                  onLoading: () => {},
                  child: CustomScrollView(
                      controller: state.scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: <Widget>[
                        viewService.buildComponent('appBar'),
                        SliverToBoxAdapter(
                            child: Container(
                          child: Container(
                              height: Adapt.height(20),
                              color: Colors.grey[200]),
                        )),
                        SliverToBoxAdapter(
                          child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  Adapt.width(40),
                                  Adapt.height(20),
                                  Adapt.width(40),
                                  Adapt.height(20)),
                              height: Adapt.height(160),
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Flex(
                                        direction: Axis.vertical,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '我的家',
                                                    style: TextStyle(
                                                        fontSize: Adapt.sp(32),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.home_outlined,
                                                    color: Colors.black45,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: Adapt.width(10),
                                                  ),
                                                  Text('广东广州.90平米.三室')
                                                ],
                                              )),
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .settings_applications_outlined,
                                                    color: Colors.black45,
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: Adapt.width(10),
                                                  ),
                                                  Text('已完成装修')
                                                ],
                                              )),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () => {},
                                        child: Row(
                                          children: [
                                            Text(
                                              '修改',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: Adapt.height(5)),
                                              child: Icon(
                                                Icons.chevron_right_rounded,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                        ),
                        SliverToBoxAdapter(
                            child: Container(
                          child: Container(
                              height: Adapt.height(20),
                              color: Colors.grey[200]),
                        )),
                        SliverPersistentHeader(
                            pinned: true,
                            delegate: StickyTabBarDelegate(
                              child: PreferredSize(
                                  preferredSize: Size.fromHeight(40),
                                  child: Material(
                                      color: Colors.grey[50],
                                      child: TabBar(
                                        onTap: (tab) => {},
                                        labelColor: Colors.black,
                                        controller: state.tabController,
                                        indicatorColor: Colors.blueGrey,
                                        // isScrollable: true,
                                        indicatorPadding: EdgeInsets.symmetric(
                                            horizontal: Adapt.width(80)),
                                        unselectedLabelColor: Colors.black45,
                                        tabs: <Widget>[
                                          Tab(
                                            text: '笔记',
                                          ),
                                          Tab(text: '收藏'),
                                          Tab(text: '点赞'),
                                        ],
                                      ))),
                            )),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: StickySizedBoxDelegate(
                            child: SizedBox(
                              height: Adapt.height(10),
                            ),
                          ),
                        ),
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: StickyDividerDelegate(
                            child: Divider(
                              thickness: Adapt.height(3),
                              height: 3.0,
                              indent: 0.0,
                              color: Colors.grey[350],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: Adapt.height(10),
                          ),
                        ),
                        SliverFillRemaining(
                          child: TabBarView(
                            controller: state.tabController,
                            children: <Widget>[
                              Center(child: Text('Content of Profile')),
                              Center(child: Text('Content of Profile')),
                              Center(child: Text('Content of Profile')),
                            ],
                          ),
                        ),
                      ]))
        ]),
      );
    },
  );
}

class StickyDividerDelegate extends SliverPersistentHeaderDelegate {
  final Divider child;

  StickyDividerDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.height;

  @override
  double get minExtent => this.child.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class StickySizedBoxDelegate extends SliverPersistentHeaderDelegate {
  final SizedBox child;

  StickySizedBoxDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.height;

  @override
  double get minExtent => this.child.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
