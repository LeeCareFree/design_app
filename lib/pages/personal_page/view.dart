import 'package:bluespace/components/article_list.dart';
import 'package:bluespace/components/backdrop.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

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
        body: CustomScrollView(
            controller: state.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: <Widget>[
              viewService.buildComponent('appBar'),
              SliverPersistentHeader(
                pinned: true,
                delegate: StickyTabBarDelegate(
                  child: TabBar(
                    labelColor: Colors.black,
                    controller: state.tabController,
                    indicatorColor: Colors.blueGrey,
                    indicatorPadding:
                        EdgeInsets.symmetric(horizontal: Adapt.width(80)),
                    unselectedLabelColor: Colors.black45,
                    tabs: <Widget>[
                      Tab(
                        text: '笔记',
                      ),
                      Tab(text: '收藏'),
                      Tab(text: '点赞'),
                    ],
                  ),
                ),
              ),
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
                    ArticleList(articleList: [
                      {
                        "imgList": [
                          "http://192.168.0.105:3000/upload/publish/Screenshot_20210314_133432.jpg",
                          "http://192.168.0.105:3000/upload/publish/Screenshot_20210314_133455.jpg",
                          "http://192.168.0.105:3000/upload/publish/Screenshot_20210314_133044.jpg",
                          "http://192.168.0.105:3000/upload/publish/Screenshot_20210314_133329.jpg"
                        ],
                        "type": "2",
                        "aid": "89fd7397-055b-4ac6-8fff-9a5820f90e62",
                        "title": "几何没学、动线设计与生活相碰撞",
                        "detail":
                            "几何美学、动线设计与生活相碰撞,隐藏式手法消弭繁杂视感,将黑灰、暖白的简洁大气映入每个人的视野中。用餐本就是-种享受，这里没有束缚,我们可以低声不语享用美食，也可以欢声笑语讲出美食奇遇，餐厅里的世界，动静皆宜，却一点都不冰冷。",
                        "like": 0,
                        "coll": 0,
                        "createtime": "2021年03月17 15:47:28",
                        "user": {
                          "username": "17324220167",
                          "nickname": "用户lxsu0l",
                          "avatar": "http://192.168.0.105:3000/imgs/avatar.jpg",
                          "uid": "1fbebca0-867b-4f7e-80c0-144f080ed644"
                        }
                      },
                      {
                        "imgList": [
                          "http://192.168.0.105:3000/upload/publish/IMG_20210316_143537.jpg",
                          "http://localhost:3000/upload/publish/IMG_20210207_131117.jpg"
                        ],
                        "type": "2",
                        "aid": "c5b208bc-63f8-4f2d-8b35-fcda91ecf52f",
                        "title": "干货小户型卧室装修布置",
                        "detail":
                            "我家新房建筑面积89m四房两厅两卫，属于小而精的户型。每一个空间虽小但是功能布局一样都没少。今天，整理了一下卧室问的比较多的问题和一些细节，收藏起来吧。\n\n卧室尺寸多少， 面积多少?\n\n主卧净尺寸: 2.95m宽*3.9m长,不含过道面积约11.5mi。\n\n卧室用的墙纸还是乳胶漆，什么色号?\n\nV拆除了精装房的墙纸，重新刷了乳胶漆，色号立邦的褐珊瑚十奶咖。\n\n褐珊瑚复古带点温馨,非常适合作为卧室床头背景颜色，其余墙面刷上奶咖，整个卧室非常舒服，暖暖的温柔。\n\n衣柜是成品还是定制，尺寸多少?\n\nV顶天立地的衣柜，尺寸1.95m宽2.8m高0.55深，衣柜的前方四开门跟普通衣柜几乎无太大区别",
                        "like": 0,
                        "coll": 0,
                        "createtime": "2021年03月17 15:47:28",
                        "user": {
                          "username": "17324220167",
                          "nickname": "用户lxsu0l",
                          "avatar": "http://192.168.0.105:3000/imgs/avatar.jpg",
                          "uid": "1fbebca0-867b-4f7e-80c0-144f080ed644"
                        }
                      },
                      {
                        "imgList": [
                          "http://192.168.0.102:3000/upload/publish/1615876262049.jpg"
                        ],
                        "type": "2",
                        "aid": "b0007136-bd14-41c6-81bb-3aa9756523be",
                        "title": "测试",
                        "detail": "测试内容",
                        "like": 0,
                        "coll": 0,
                        "createtime": "2021年03月17 15:47:28",
                        "user": {
                          "username": "17324220167",
                          "nickname": "用户lxsu0l",
                          "avatar": "http://192.168.0.105:3000/imgs/avatar.jpg",
                          "uid": "1fbebca0-867b-4f7e-80c0-144f080ed644"
                        }
                      }
                    ]),
                    Center(child: Text('Content of Profile')),
                    Center(child: Text('Content of Profile')),
                  ],
                ),
              ),
            ]),
      );
    },
  );
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
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
