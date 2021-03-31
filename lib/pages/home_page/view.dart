import 'package:bluespace/components/gifRefresh.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/pages/personal_page/view.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bluespace/components/article_list.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    void test(_refreshController) async {
      await Future.delayed(Duration(milliseconds: 1000));
      _refreshController.loadComplete();
    }

    return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.light,
          elevation: 3.0,
          title: _SearchBar(
            onTap: () => dispatch(HomeActionCreator.onSearchBarTapped()),
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                    child: Container(
                  padding: EdgeInsets.only(
                      top: Adapt.height(10), bottom: Adapt.height(10)),
                  child: state.bannerList.length != 0
                      ? viewService.buildComponent('swiper')
                      : Container(
                          margin: EdgeInsets.all(5),
                          width: Adapt.width(750),
                          height: Adapt.height(400),
                          color: Color.fromRGBO(0, 0, 0, .3),
                        ),
                )),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabBarDelegate(
                      child: PreferredSize(
                          preferredSize: Size.fromHeight(40),
                          child: Material(
                            color: Colors.grey[50],
                            child: TabBar(
                                onTap: (tab) => {
                                      dispatch(HomeActionCreator.getArticleList(
                                          1, tab.toString()))
                                    },
                                labelColor: Colors.black,
                                controller: state.tabController,
                                indicatorColor: Colors.blueGrey,
                                // isScrollable: true,
                                indicatorPadding: EdgeInsets.symmetric(
                                    horizontal: Adapt.width(80)),
                                unselectedLabelColor: Colors.black45,
                                tabs: state.tabs
                                    .map((e) => Tab(
                                          text: e,
                                        ))
                                    .toList()),
                          ))),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: StickySizedBoxDelegate(
                    child: SizedBox(
                      height: Adapt.height(10),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: state.tabController,
              children: state.tabs.asMap().entries.map((entry) {
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: state.refreshController,
                    onRefresh: () => {
                          dispatch(HomeActionCreator.getBanner()),
                          dispatch(HomeActionCreator.getArticleList(
                              1, entry.key.toString()))
                        },
                    onLoading: () => {
                          print('loading'),
                          dispatch(HomeActionCreator.getArticleList(
                              state.pageIndex + 1, entry.key.toString()))
                        },
                    child: ArticleList(articleList: state.articleList));
              }).toList(),
            )));
  });
  // return Container();
}

class _SearchBar extends StatelessWidget {
  final Function onTap;
  const _SearchBar({this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(left: Adapt.width(30), right: Adapt.width(30)),
        height: Adapt.height(65),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.radius(40)),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(width: Adapt.width(20)),
            SizedBox(
              width: Adapt.screenW() - Adapt.width(200),
              child: Text(
                '搜索',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.sp(28)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.height(30)),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(_theme.iconTheme.color),
        ),
      ),
    );
  }
}
