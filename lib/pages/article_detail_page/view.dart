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
            backgroundColor: _theme.bottomAppBarColor,
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
          bottomNavigationBar: (_FixedRow()),
          body: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(vertical: Adapt.height(30)),
              // physics: BouncingScrollPhysics(),
              // shrinkWrap: true,
              child: Column(children: [
            SizedBox(
              height: Adapt.height(30),
            ),
            viewService.buildComponent('swiper'),
            _ArticleWidget(
              title: state.title ?? '这是标题',
              content: state.content ??
                  '这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容',
              time: state.time ?? '2021年3月13日 17.00',
            ),
            // _FixedRow()
            // viewService.buildComponent('title'),
            // viewService.buildComponent('cast'),
            // viewService.buildComponent('season'),
            // viewService.buildComponent('lastEpisode'),
            // viewService.buildComponent('keyword'),
            // viewService.buildComponent('recommendation'),
            _CommentWidget(
              avatar:
                  state.avatar ?? 'http://192.168.0.105:3000/imgs/avatar.jpg',
              commentCount: 666,
            )
          ])));
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
            height: Adapt.height(50),
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
          Adapt.height(20), 0, Adapt.height(20), Adapt.height(20)),
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
            style: TextStyle(fontSize: Adapt.sp(34), letterSpacing: 1.0),
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

class _FixedRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode blankNode = FocusNode();
    return Container(
        width: Adapt.screenW(),
        height: Adapt.height(100),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(width: Adapt.width(1), color: Colors.grey))),
        child: Flex(
          direction: Axis.horizontal,
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.only(left: Adapt.width(30)),
                  decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
                  height: Adapt.height(60),
                  child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(blankNode);
                      },
                      child: Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                Adapt.width(20),
                                Adapt.height(5),
                                Adapt.width(10),
                                Adapt.height(28)),
                            border: InputBorder.none,
                            hintText: "评论一下...",
                            hintStyle: TextStyle(
                              fontSize: Adapt.sp(30),
                              height: Adapt.height(2),
                            ),
                          ),
                        ),
                      ))),
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: Adapt.width(70),
                      margin: EdgeInsets.only(right: Adapt.width(10)),
                      child: IconButton(
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            size: Adapt.height(50),
                          ),
                          onPressed: () => {}),
                    ),
                    Text(
                      '6.6万',
                      style: TextStyle(fontSize: Adapt.sp(28)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                child: Row(
                  children: [
                    Container(
                      width: Adapt.width(70),
                      margin: EdgeInsets.only(right: Adapt.width(10)),
                      child: IconButton(
                          icon: Icon(
                            Icons.star_border_outlined,
                            size: Adapt.height(50),
                          ),
                          onPressed: () => {}),
                    ),
                    Text(
                      '6.6万',
                      style: TextStyle(fontSize: Adapt.sp(28)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                margin: EdgeInsets.only(right: Adapt.width(30)),
                child: Row(
                  children: [
                    Container(
                      width: Adapt.width(70),
                      margin: EdgeInsets.only(right: Adapt.width(10)),
                      child: IconButton(
                          icon: Icon(
                            Icons.sms_outlined,
                            size: Adapt.height(50),
                          ),
                          onPressed: () => {}),
                    ),
                    Text(
                      '6.6万',
                      style: TextStyle(fontSize: Adapt.sp(28)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class _CommentWidget extends StatelessWidget {
  final int commentCount;
  final String avatar;
  const _CommentWidget({this.commentCount, this.avatar});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(30), 0, Adapt.width(30), 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '共$commentCount条评论',
                style: TextStyle(color: Colors.grey, fontSize: Adapt.sp(24)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, Adapt.width(20), 0, Adapt.width(20)),
            child: Flex(
              direction: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipOval(
                    child: Image.network(
                      avatar,
                      fit: BoxFit.cover,
                      width: 35,
                      height: 35,
                      // color: Colors.black
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                      margin: EdgeInsets.only(left: Adapt.width(30)),
                      decoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border.all(color: Colors.grey),
                          borderRadius:
                              BorderRadius.circular(Adapt.radius(50))),
                      height: Adapt.height(60),
                      child: GestureDetector(
                          onTap: () {
                            // FocusScope.of(context).requestFocus(blankNode);
                          },
                          child: Form(
                            child: TextFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    Adapt.width(20),
                                    Adapt.height(5),
                                    Adapt.width(10),
                                    Adapt.height(27)),
                                border: InputBorder.none,
                                hintText: "评论一下...",
                                hintStyle: TextStyle(
                                  fontSize: Adapt.sp(30),
                                  height: Adapt.height(2),
                                ),
                              ),
                            ),
                          ))),
                ),
              ],
            ),
          ),
          _CommentListWidget([
            {
              'avatar': 'http://192.168.0.105:3000/imgs/avatar.jpg',
              'nickname': '你的名字',
              'content': '你的评论',
              'time': '03-16'
            },
            {
              'avatar': 'http://192.168.0.105:3000/imgs/avatar.jpg',
              'nickname': '你的名字',
              'content': '你的评论',
              'time': '03-16'
            },
            {
              'avatar': 'http://192.168.0.105:3000/imgs/avatar.jpg',
              'nickname': '你的名字',
              'content': '你的评论',
              'time': '03-16'
            },
            {
              'avatar': 'http://192.168.0.105:3000/imgs/avatar.jpg',
              'nickname': '你的名字',
              'content': '你的评论',
              'time': '03-16'
            }
          ])
        ],
      ),
    );
  }
}

class _CommentListWidget extends StatelessWidget {
  final List commentList;
  const _CommentListWidget(this.commentList);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.height(110) * commentList.length,
      margin: EdgeInsets.only(top: Adapt.height(20)),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: commentList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: Adapt.height(30),
                color: Color(0xFFFFFFFF),
              ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.only(bottom: Adapt.height(10)),
                decoration: BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1, color: Color(0xffe5e5e5)))),
                child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ClipOval(
                          child: Image.network(
                            commentList[index]['avatar'] ??
                                'http://192.168.0.105:3000/imgs/avatar.jpg',
                            fit: BoxFit.cover,
                            width: 35,
                            height: 35,
                            // color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(
                        width: Adapt.width(40),
                      ),
                      Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${commentList[index]['nickname'] ?? commentList[index].username}' ??
                                        'test',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Adapt.sp(24)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Adapt.height(5),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('${commentList[index]['content']}' ??
                                      'test'),
                                  SizedBox(
                                    width: Adapt.width(10),
                                  ),
                                  Text(
                                    '${commentList[index]['time']}' ?? '03-16',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: Adapt.sp(24)),
                                  )
                                ],
                              )
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: Adapt.width(25)),
                              width: Adapt.width(40),
                              height: Adapt.height(40),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: Adapt.height(30),
                                  ),
                                  onPressed: () => {}),
                            ),
                            SizedBox(
                              height: Adapt.height(5),
                            ),
                            Text(
                              '666',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: Adapt.sp(24)),
                            ),
                          ],
                        ),
                      )
                    ]));
          }),
    );
  }
}
