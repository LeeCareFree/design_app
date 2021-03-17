/*
 * @Author: your name
 * @Date: 2021-03-15 18:14:14
 * @LastEditTime: 2021-03-16 14:16:26
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \design_app\lib\components\article_list.dart
 */
import 'package:flutter/material.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:bluespace/style/themeStyle.dart';

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
      itemBuilder: (context, i) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('articleDetailPage', arguments: {'aid': articleList[i]['aid']});
        },
        child: ArticleItem(
          img: articleList[i]['imgList'] != null
              ? '${articleList[i]['imgList'][0]}'
              : '${articleList[i]['cover']}',
          title: '${articleList[i]['title']}',
          username: articleList[i]['user']['nickname'] ??
              articleList[i]['user']['username'],
          avatar: '${articleList[i]['user']['avatar']}',
          type: '${articleList[i]['type']}',
          coll: '${articleList[i]['coll']}',
        ),
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
                        coll.toString() == '0'
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
