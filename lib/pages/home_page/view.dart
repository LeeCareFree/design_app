import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  // if (state.bannerList.length == 0) {
  //   dispatch(HomeActionCreator.getBanner());
  // }

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.light,
          elevation: 0.0,
          title: _SearchBar(
            onTap: () => dispatch(HomeActionCreator.onSearchBarTapped()),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: Adapt.height(10), bottom: Adapt.height(20)),
                child: state.bannerList.length != 0
                    ? SwiperDiy(swiperDataList: state.bannerList)
                    : Container(
                        margin: EdgeInsets.all(5),
                        width: Adapt.width(750),
                        height: Adapt.height(400),
                        color: Color.fromRGBO(0, 0, 0, .3),
                      ),
              ),
              ArticleList()
            ],
          ),
        ));
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
        height: Adapt.height(70),
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

// 轮播图
class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.width(750),
      height: Adapt.height(400),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Adapt.width(750),
                  height: Adapt.height(80),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                    child: Text(
                      "${swiperDataList[index].title}",
                      style: TextStyle(color: Colors.white),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 0, 0, 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Adapt.radius(10)),
                          bottomRight: Radius.circular(Adapt.radius(10)))),
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${swiperDataList[index].img}"),
                    fit: BoxFit.fill),
                borderRadius:
                    BorderRadius.all(Radius.circular(Adapt.radius(10)))),
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(
            margin: EdgeInsets.only(top: 10),
            builder: DotSwiperPaginationBuilder(
              color: Colors.white70,
              activeColor: _theme.buttonColor,
            )),
        autoplay: true,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}

class ArticleList extends StatelessWidget {
  ArticleList({Key key}) : super(key: key);
  final List list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      itemCount: list.length,
      itemBuilder: (context, i) => ArticleItem(),
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
    );
  }
}

class ArticleItem extends StatelessWidget {
  final String img;
  final String title;
  final String username;
  final String avatar;
  final String type;
  final String coll;

  ArticleItem(
      {this.img, this.title, this.username, this.avatar, this.type, this.coll});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.pink,
            height: ScreenUtil().setHeight(200),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10)),
            child: Text(
              '这是标题',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                bottom: ScreenUtil().setWidth(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.lightBlue,
                  radius: ScreenUtil().setWidth(20),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(10),
                      right: ScreenUtil().setWidth(10)),
                  width: ScreenUtil().setWidth(180),
                  child: Text(
                    '这里是作者',
                    style: TextStyle(fontSize: ScreenUtil().setSp(22)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                    color: Colors.teal,
                    width: ScreenUtil().setWidth(80),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outline,
                          size: ScreenUtil().setSp(38),
                        ),
                        0 == 0
                            ? Text('')
                            : Text(
                                '11',
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(22)),
                              )
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
