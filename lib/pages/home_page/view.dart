import 'package:bluespace/components/gifRefresh.dart';
import 'package:bluespace/components/searchBar.dart';
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
    return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.light,
          elevation: 3.0,
          title: SearchBar(
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
                  child: state.bannerList?.length != 0
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
                                          1, tab))
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
            body:
                TabBarView(controller: state.tabController, children: <Widget>[
              SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: state.refreshController,
                  onRefresh: () => {
                        dispatch(HomeActionCreator.getBanner()),
                        dispatch(HomeActionCreator.getArticleList(1, 0))
                      },
                  onLoading: () => {
                        dispatch(HomeActionCreator.getArticleList(
                            state.pageIndex0 + 1, 0))
                      },
                  child: ArticleList(
                    articleList: state.articleList0,
                    type: 'home',
                    dispatch: dispatch,
                  )),
              SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: state.refreshController,
                  onRefresh: () => {
                        dispatch(HomeActionCreator.getBanner()),
                        dispatch(HomeActionCreator.getArticleList(1, 1))
                      },
                  onLoading: () => {
                        dispatch(HomeActionCreator.getArticleList(
                            state.pageIndex1 + 1, 1))
                      },
                  child: ArticleList(
                    articleList: state.articleList1,
                    type: 'home',
                    dispatch: dispatch,
                  )),
              SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: state.refreshController,
                  onRefresh: () => {
                        dispatch(HomeActionCreator.getBanner()),
                        dispatch(HomeActionCreator.getArticleList(1, 2))
                      },
                  onLoading: () => {
                        dispatch(HomeActionCreator.getArticleList(
                            state.pageIndex2 + 1, 2))
                      },
                  child: ArticleList(
                    articleList: state.articleList2,
                    type: 'home',
                    dispatch: dispatch,
                  )),
              SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: state.refreshController,
                  onRefresh: () => {
                        dispatch(HomeActionCreator.getBanner()),
                        dispatch(HomeActionCreator.getArticleList(1, 3))
                      },
                  onLoading: () => {
                        dispatch(HomeActionCreator.getArticleList(
                            state.pageIndex3 + 1, 3))
                      },
                  child: ArticleList(
                    articleList: state.articleList3,
                    type: 'home',
                    dispatch: dispatch,
                  )),
            ])));
  });
  // return Container();
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
