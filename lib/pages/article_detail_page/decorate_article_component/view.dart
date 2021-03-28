import 'package:bluespace/components/asperctRaioImage.dart';
import 'package:bluespace/components/fitImage.dart';
import 'package:bluespace/models/decorate_article.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DecorateArticleState state, Dispatch dispatch, ViewService viewService) {
  return CustomScrollView(physics: BouncingScrollPhysics(), slivers: [
    SliverToBoxAdapter(
      child: GestureDetector(
          onTap: () => {},
          child: ItemFitWidthNetImage(
              'http://192.168.0.103:3000/upload/publish/XHS_161649703329460bdf124-6ab8-3341-836a-b8b7a7b751ba.jpg',
              Adapt.screenW())),
    ),
    SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(30), Adapt.height(30), 0, 0),
      child: Text(
        state.decorateArticle?.title ?? '我的99万装修',
        style: TextStyle(fontSize: Adapt.sp(46), fontWeight: FontWeight.bold),
      ),
    )),
    _HouseDescWidget(decorateArticle: state.decorateArticle),
    SliverToBoxAdapter(
        child: Container(
      margin: EdgeInsets.only(top: Adapt.height(30)),
      color: Colors.grey[200],
      height: Adapt.height(10),
      width: Adapt.screenW(),
    )),
    _ArticleContent()
  ]);
}

class _HouseDescWidget extends StatelessWidget {
  final DecorateArticle decorateArticle;
  const _HouseDescWidget({this.decorateArticle});
  @override
  Widget build(BuildContext context) {
    var descList = [
      {
        'icon': Icon(Icons.house_outlined),
        'content': '户型：${decorateArticle?.doorModel ?? '三室一厅'}'
      },
      {
        'icon': Icon(Icons.select_all_rounded),
        'content': '面积：${decorateArticle?.area ?? '98平米'}'
      },
      {
        'icon': Icon(Icons.money_rounded),
        'content': '花费：${decorateArticle?.cost ?? '99万'}'
      },
      {
        'icon': Icon(Icons.location_on_outlined),
        'content': '位置：${decorateArticle?.location ?? '广东广州'}'
      },
      {
        'icon': Icon(Icons.stairs_outlined),
        'content': decorateArticle?.duplex ?? '复式'
      },
    ];
    return SliverGrid.count(
      crossAxisCount: 2,
      // mainAxisSpacing: Adapt.height(30),
      // crossAxisSpacing: Adapt.width(30),
      childAspectRatio: 5,
      children: descList
          .map((e) => Container(
                margin: EdgeInsets.fromLTRB(
                    Adapt.width(25), Adapt.height(25), 0, 0),
                child: Row(
                  children: [
                    e['icon'],
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(e['content']),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class _ArticleContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            margin:
                EdgeInsets.fromLTRB(Adapt.width(30), Adapt.height(30), 0, 0),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    '介绍一下',
                    style: TextStyle(
                        fontSize: Adapt.sp(38), fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Adapt.height(30),
                  ),
                  Text(
                    '我家整体是以原木色和白色为主，所以在电器上选择了很多米家产品，他家生态链产品基本都是白色，跟我家风格很相符，重点是性价比极高，设计简约，有什么理由不选择它呢？吸顶灯，电热水壶，插座，台灯，电池，摄像头，智能门锁，电饭煲、扫地机器人等，我家随处可见米家的产品，不得不说生态链产品真的很全很丰富~配合他家的APP，可以智能联动，非常推荐他家的智能插座，可以在下班到家前通过智能插座提前打开空调，回到家就能吹到空调简不要太爽，也不会浪费电费！',
                    style: TextStyle(
                        fontSize: Adapt.sp(36),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.0),
                  ),
                  SizedBox(
                    height: Adapt.height(30),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: Adapt.height(30)),
                    color: Colors.grey[200],
                    height: Adapt.height(3),
                    width: Adapt.screenW(),
                  ),
                  SizedBox(
                    height: Adapt.height(30),
                  ),
                  Text(
                    '户型图',
                    style: TextStyle(
                        fontSize: Adapt.sp(38), fontWeight: FontWeight.bold),
                  ),
                  // Swiper(
                  //   itemCount: 3,
                  // )
                ]))));
  }
}
