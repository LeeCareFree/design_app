import 'dart:ui';

import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ArticleDetailState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        appBar: AppBar(
          iconTheme: _theme.iconTheme,
          elevation: 3.0,
          backgroundColor: _theme.backgroundColor,
          brightness: _theme.brightness,
          actions: [
            Row(
              children: [
                _UserInfoWidget(
                  avatar: state.avatar ??
                      'http://192.168.0.105:3000/imgs/avatar.jpg',
                  username: state.username ?? 'test',
                  theme: _theme,
                ),
              ],
            ),
            IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () =>
                    dispatch(ArticleDetailActionCreator.openMenu()))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: Adapt.height(30)),
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            viewService.buildComponent('swiper'),

            _ArticleWidget(
              title: state.title ?? '这是标题',
              content: state.content ??
                  '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容',
              time: state.time ?? '2021年3月13日 17.00',
            ),
            _FloatRow()
            // viewService.buildComponent('title'),
            // viewService.buildComponent('cast'),
            // viewService.buildComponent('season'),
            // viewService.buildComponent('lastEpisode'),
            // viewService.buildComponent('keyword'),
            // viewService.buildComponent('recommendation'),
          ],
        ),
      );
    },
  );
}

class _UserInfoWidget extends StatelessWidget {
  final String username;
  final String avatar;
  final theme;
  const _UserInfoWidget({this.username, this.avatar, this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: Adapt.px(0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 用户头像
          ClipOval(
            child: Image.network(
              avatar,
              fit: BoxFit.cover,
              width: 35,
              height: 35,
              // color: Colors.black
            ),
          ),
          SizedBox(
            width: Adapt.width(10),
          ),
          Text(
            username,
            style: TextStyle(
                fontSize: Adapt.sp(38),
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: Adapt.width(260),
          ),
          Container(
            width: Adapt.width(100),
            height: Adapt.height(60),
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(Adapt.radius(50))),
            child: Container(
                child: TextButton(
                    onPressed: () => {},
                    child: Text(
                      "关注",
                      style: TextStyle(
                          fontSize: Adapt.sp(24),
                          fontWeight: FontWeight.bold,
                          // letterSpacing: Adapt.px(10),
                          color: Colors.white),
                    ))),
          ),
        ],
      ),
    );
  }
}

class _ArticleWidget extends StatelessWidget {
  final String title;
  final String content;
  final String time;
  const _ArticleWidget({this.title, this.content, this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          Adapt.width(35), 0, Adapt.width(35), Adapt.height(35)),
      padding: EdgeInsets.all(Adapt.height(10)),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: Adapt.height(25)),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: Adapt.sp(38), fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: Adapt.sp(34), letterSpacing: 2.0),
          ),
          Container(
            margin:
                EdgeInsets.fromLTRB(0, Adapt.height(30), 0, Adapt.height(30)),
            child: Row(
              children: [
                Text(
                  '发布于 $time',
                  style: TextStyle(fontSize: Adapt.sp(24), color: Colors.grey),
                )
              ],
            ),
          ),
          Divider(
            height: 2.0,
            indent: 0.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _FloatRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        child: Row(
          children: [
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/like.png')),
                ),
              ),
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/like.png')),
                ),
              ),
            ),
            InkWell(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/like.png')),
                ),
              ),
            ),
          ],
        ));
  }
}
