import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
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
                    top: Adapt.height(10), bottom: Adapt.height(10)),
                child: state.bannerList.length != 0
                    ? viewService.buildComponent('swiper')
                    : Container(
                        margin: EdgeInsets.all(5),
                        width: Adapt.width(750),
                        height: Adapt.height(400),
                        color: Color.fromRGBO(0, 0, 0, .3),
                      ),
              ),
              ArticleList(articleList: state.articleList)
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

class ArticleList extends StatelessWidget {
  final List articleList;

  ArticleList({Key key, this.articleList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      itemCount: articleList.length,
      itemBuilder: (context, i) => ArticleItem(
        img: articleList[i]['imgList'] != null
            ? '${articleList[i]['imgList'][0]}'
            : '${articleList[i]['cover']}',
        title: '${articleList[i]['title']}',
        username: '${articleList[i]['username']}',
        avatar: '${articleList[i]['avatar']}',
        type: '${articleList[i]['type']}',
        coll: '${articleList[i]['coll']}',
      ),
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
            height: type == '2' ? Adapt.height(300) : Adapt.height(250),
            width: Adapt.width(750),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Adapt.width(5)),
                    topRight: Radius.circular(Adapt.width(5))),
                image: DecorationImage(
                    image: NetworkImage(img), fit: BoxFit.fill)),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Adapt.width(20)),
            margin: EdgeInsets.symmetric(vertical: Adapt.width(10)),
            child: Text(
              '$title',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding:
                EdgeInsets.only(left: Adapt.width(20), bottom: Adapt.width(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                  radius: Adapt.width(20),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: Adapt.width(10), right: Adapt.width(10)),
                  width: Adapt.width(180),
                  child: Text(
                    '$username',
                    style: TextStyle(fontSize: Adapt.sp(22)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                    width: Adapt.width(80),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star_outline,
                          size: Adapt.sp(38),
                        ),
                        coll.toString() == '0'
                            ? Text('')
                            : Text(
                                '$coll',
                                style: TextStyle(fontSize: Adapt.sp(22)),
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
