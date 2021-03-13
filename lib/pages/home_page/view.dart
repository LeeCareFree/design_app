import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  if (state.bannerList.length == 0) {
    dispatch(HomeActionCreator.getBanner());
  }

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
                padding:
                    EdgeInsets.only(top: Adapt.px(10), bottom: Adapt.px(20)),
                child: state.bannerList.length != 0
                    ? SwiperDiy(swiperDataList: state.bannerList)
                    : Container(
                        margin: EdgeInsets.all(5),
                        width: Adapt.px(750),
                        height: Adapt.px(400),
                        color: Color.fromRGBO(0, 0, 0, .3),
                      ),
              ),
              PublishList()
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
        padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
        height: Adapt.px(70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(40)),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.search,
              color: Colors.grey,
            ),
            SizedBox(width: Adapt.px(20)),
            SizedBox(
              width: Adapt.screenW() - Adapt.px(200),
              child: Text(
                '搜索',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(28)),
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
      width: Adapt.px(750),
      height: Adapt.px(400),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: Adapt.px(750),
                  height: Adapt.px(80),
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
                          bottomLeft: Radius.circular(Adapt.px(10)),
                          bottomRight: Radius.circular(Adapt.px(10)))),
                )
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("${swiperDataList[index].imgList[0]}"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.all(Radius.circular(Adapt.px(10)))),
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

class PublishList extends StatelessWidget {
  PublishList({Key key}) : super(key: key);
  final List list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4, 
      itemCount: list.length,
      itemBuilder: (context,i){
          return Container(
            color: _theme.buttonColor,
          );
      }, 
      staggeredTileBuilder: (index){
        return StaggeredTile.count(2, index.isEven ? 2 : 1);  //第一个参数是横轴所占的单元数，第二个参数是主轴所占的单元数
      },
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
    );
  }
}
