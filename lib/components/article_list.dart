/*
 * @Author: your name
 * @Date: 2021-03-15 18:14:14
 * @LastEditTime: 2021-03-31 12:49:44
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\components\article_list.dart
 */
import 'package:bluespace/models/article_list_data.dart';
import 'package:bluespace/pages/home_page/action.dart';
import 'package:bluespace/pages/personal_page/action.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/components/fitImage.dart';

class ArticleList extends StatelessWidget {
  final List articleList;
  final Dispatch dispatch;
  final String type;
  ArticleList({Key key, this.articleList, this.dispatch, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      itemCount: articleList.length,
      itemBuilder: (context, i) {
        final ArticleListData item = ArticleListData.fromJson(articleList[i]);
        return InkWell(
          onTap: () => {
            type == 'personal'
                ? dispatch(PersonalActionCreator.goArticleDetail(
                    'videoPage', {'type': item.type, 'aid': item.aid}))
                : dispatch(HomeActionCreator.goArticleDetail(
                    'videoPage', {'type': item.type, 'aid': item.aid}))
          },
          child: ArticleItem(
            img: item.type == "2" ? item.imgList[0] : item.cover,
            title: item.title,
            username: item.user.nickname ?? item.user.username,
            avatar: item.user.avatar,
            type: item.type,
            coll: item.coll,
            doorModel: item.doorModel,
            area: item.area,
            cost: item.cost,
            location: item.location,
          ),
        );
      },
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
  final String doorModel;
  final String area;
  final String cost;
  final String location;
  final int coll;

  ArticleItem(
      {this.img,
      this.title,
      this.username,
      this.avatar,
      this.type,
      this.coll,
      this.doorModel,
      this.area,
      this.cost,
      this.location});

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // height: 250,
            width: Adapt.screenW(),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Adapt.width(5)),
                    topRight: Radius.circular(Adapt.width(5))),
                child: FadeInImage(
                    // image: NetworkImage(url),
                    image: NetworkImage(img),
                    placeholder: AssetImage('assets/images/outfigure.gif'),
                    fit: BoxFit.cover)),
          ),
          type == '1'
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: Adapt.width(10)),
                  margin: EdgeInsets.only(top: Adapt.width(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.house_outlined,
                            color: _theme.buttonColor,
                            size: Adapt.height(25),
                          ),
                          Text(
                            '$doorModel·$area·$cost',
                            style: TextStyle(
                                fontSize: Adapt.sp(24), color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: _theme.buttonColor,
                              size: Adapt.height(25)),
                          Text('$location',
                              style: TextStyle(
                                  fontSize: Adapt.sp(22), color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      )
                    ],
                  ))
              : Container(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: Adapt.width(20)),
            margin: EdgeInsets.symmetric(vertical: Adapt.width(10)),
            child: Text(
              '$title',
              style: TextStyle(
                  fontSize: Adapt.sp(30), fontWeight: FontWeight.bold),
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
                    width: Adapt.width(95),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: Adapt.width(2)),
                          child: Icon(
                            Icons.star_outline,
                            size: Adapt.sp(38),
                          ),
                        ),
                        coll == 0
                            ? Text('')
                            : Text(
                                '$coll',
                                style: TextStyle(fontSize: Adapt.sp(22)),
                                textAlign: TextAlign.center,
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
