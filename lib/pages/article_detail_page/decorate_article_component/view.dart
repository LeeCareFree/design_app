import 'package:bluespace/components/asperctRaioImage.dart';
import 'package:bluespace/components/fitImage.dart';
import 'package:bluespace/components/swiperPanel.dart';
import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DecorateArticleState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
      child: GestureDetector(
          onTap: () => {},
          child:
              ItemFitWidthNetImage(state.articleInfo.cover, Adapt.screenW())),
    ),
    Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(30), Adapt.height(30), 0, 0),
      child: Text(
        state.articleInfo?.title,
        style: TextStyle(fontSize: Adapt.sp(46), fontWeight: FontWeight.bold),
      ),
    ),
    _HouseDescWidget(articleInfo: state.articleInfo),
    Container(
      margin: EdgeInsets.only(top: Adapt.height(30)),
      color: Colors.grey[200],
      height: Adapt.height(10),
      width: Adapt.screenW(),
    ),
    _ArticleContent(
      articleInfo: state.articleInfo,
    )
  ]));
}

class _HouseDescWidget extends StatelessWidget {
  final ArticleInfo articleInfo;
  const _HouseDescWidget({this.articleInfo});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(Adapt.width(30), Adapt.height(30), 0, 0),
        height: Adapt.height(180),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.house_outlined),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(articleInfo.doorModel)
                  ],
                ),
                SizedBox(
                  height: Adapt.height(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.money_rounded),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(articleInfo.cost)
                  ],
                ),
                SizedBox(
                  height: Adapt.height(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.stairs_outlined),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(articleInfo.duplex)
                  ],
                ),
              ],
            ),
            SizedBox(
              width: Adapt.width(50),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.select_all_rounded),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(articleInfo.area)
                  ],
                ),
                SizedBox(
                  height: Adapt.height(20),
                ),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(
                      width: Adapt.width(10),
                    ),
                    Text(articleInfo.location)
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class _ArticleContent extends StatelessWidget {
  final ArticleInfo articleInfo;
  const _ArticleContent({this.articleInfo});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(Adapt.height(20)),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '介绍一下',
            style:
                TextStyle(fontSize: Adapt.sp(38), fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: Adapt.height(25),
          ),
          Text(
            articleInfo.detail,
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
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: articleInfo.desc.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) =>
                  _PartList(desc: articleInfo.desc[index])),
        ])));
  }
}

class _PartList extends StatelessWidget {
  final Desc desc;
  final ViewService viewService;
  const _PartList({this.desc, this.viewService});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          desc?.title,
          style: TextStyle(fontSize: Adapt.sp(38), fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Adapt.height(30),
        ),
        Text(
          desc?.content,
          style: TextStyle(fontSize: Adapt.sp(36), letterSpacing: 1.0),
        ),
        SizedBox(
          height: Adapt.height(30),
        ),
        SwiperPanel(
          backdrops: desc.imgList,
        ),
      ],
    ));
  }
}
