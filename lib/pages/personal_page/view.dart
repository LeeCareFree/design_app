import 'package:bluespace/components/article_list.dart';
import 'package:bluespace/components/customAppbar.dart';
import 'package:bluespace/components/loading.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    // bool _showTitle = state.scrollController.hasClients &&
    //     state.scrollController.offset > Adapt.height(350) - Adapt.height(300);
    return WillPopScope(
        onWillPop: () {
          dispatch(PersonalActionCreator.back());

          ///true：表示执行页面返回    false:表示不执行返回页面操作，这里因为要传值，所以接管返回操作
          return Future.value(false);
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(children: [
              state.isLoading
                  ? LoadingLayout(
                      title: '加载中...',
                      show: true,
                    )
                  : NestedScrollView(
                      controller: state.scrollController,
                      physics: BouncingScrollPhysics(),
                      headerSliverBuilder: (context, value) {
                        return [
                          CustomAppBar(
                            accountInfo: state.accountInfo,
                            controller: state.scrollController,
                            uid: state.mineUid ?? '',
                            isFollow: state.isFollow ?? false,
                            dispatch: dispatch,
                          ),
                          SliverToBoxAdapter(
                              child: Container(
                            child: Container(
                                height: Adapt.height(20),
                                color: Colors.grey[200]),
                          )),
                          SliverToBoxAdapter(
                            child: InkWell(
                                onTap: () => state.mineUid !=
                                        state.accountInfo?.uid
                                    ? {}
                                    : dispatch(PersonalActionCreator
                                        .toChangeMyhomeInfo('myhomeSettingPage',
                                            {'homeInfo': state.myhomeInfo})),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        Adapt.width(40),
                                        Adapt.height(20),
                                        Adapt.width(0),
                                        Adapt.height(20)),
                                    height: Adapt.height(160),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                                              fontSize:
                                                                  Adapt.sp(32),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          width:
                                                              Adapt.width(10),
                                                        ),
                                                        Text(
                                                          state.myhomeInfo
                                                                      ?.area !=
                                                                  null
                                                              ? '${state.myhomeInfo.city}.${state.myhomeInfo.area}.${state.myhomeInfo.doorModel}'
                                                              : '待完善',
                                                          style: TextStyle(
                                                            fontSize:
                                                                Adapt.sp(26),
                                                          ),
                                                        )
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
                                                          width:
                                                              Adapt.width(10),
                                                        ),
                                                        Text(
                                                            state.myhomeInfo
                                                                        ?.progress !=
                                                                    null
                                                                ? state
                                                                    .myhomeInfo
                                                                    .progress
                                                                : '待完善',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Adapt.sp(
                                                                        26)))
                                                      ],
                                                    )),
                                              ],
                                            )),
                                        Expanded(
                                          flex: 1,
                                          child: state.mineUid !=
                                                  state.accountInfo?.uid
                                              ? Container()
                                              : Row(
                                                  children: [
                                                    Text(
                                                      '修改',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Adapt.height(5)),
                                                      child: Icon(
                                                        Icons
                                                            .chevron_right_rounded,
                                                        color: Colors.grey,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                        )
                                      ],
                                    ))),
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
                                        onTap: (tab) => {
                                          dispatch(PersonalActionCreator
                                              .getArticleList(1, tab))
                                        },
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
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        controller: state.tabController,
                        children: <Widget>[
                          SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              controller: state.refreshController,
                              onRefresh: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            1, 0))
                                  },
                              onLoading: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            state.pageIndex0 + 1, 0))
                                  },
                              child: ArticleList(
                                  articleList: state.articleList0,
                                  type: 'personal',
                                  dispatch: dispatch)),
                          SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              controller: state.refreshController,
                              onRefresh: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            1, 1))
                                  },
                              onLoading: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            state.pageIndex1 + 1, 1))
                                  },
                              child: ArticleList(
                                  articleList: state.articleList1,
                                  type: 'personal',
                                  dispatch: dispatch)),
                          SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: true,
                              controller: state.refreshController,
                              onRefresh: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            1, 2))
                                  },
                              onLoading: () => {
                                    dispatch(
                                        PersonalActionCreator.getArticleList(
                                            state.pageIndex2 + 1, 2))
                                  },
                              child: ArticleList(
                                  articleList: state.articleList2,
                                  type: 'personal',
                                  dispatch: dispatch)),
                        ],
                      ))
            ])));
  });
}
