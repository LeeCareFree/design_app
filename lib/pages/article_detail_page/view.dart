import 'dart:ui';

import 'package:bluespace/components/asperctRaioImage.dart';
import 'package:bluespace/components/loading.dart';
import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ArticleDetailState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      switch (state.articleType) {
        case '1':
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
                        avatar: state.articleInfo?.user?.avatar ?? '',
                        username: state.articleInfo?.user?.nickname ?? '',
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
              bottomNavigationBar: (!state.isLoading
                  ? _FixedRow(
                      controller: state.commentTextController,
                      commentFocusNode: state.commentFocusNode,
                      dispatch: dispatch,
                      articleDetail: state.articleInfo,
                      isColl: state.isColl,
                      isLike: state.isLike,
                    )
                  : null),
              body: Stack(
                children: [
                  state.isLoading
                      ? LoadingLayout(
                          title: '加载中...',
                          show: true,
                        )
                      : SingleChildScrollView(
                          child: Column(children: [
                          SizedBox(
                            height: Adapt.height(10),
                          ),
                          viewService.buildComponent('swiper'),
                          _ArticleWidget(
                            title: state.articleInfo.title,
                            content: state.articleInfo.detail,
                            time: state.articleInfo.createtime,
                          ),
                          _CommentWidget(
                            avatar: state.avatar,
                            commentList: state.articleInfo.comments,
                            controller: state.commentTextController,
                            commentFocusNode: state.commentFocusNode,
                            commentLikeCount: state.commentLikeCount,
                            dispatch: dispatch,
                          ),
                        ]))
                ],
              ));
          break;
        case '2':
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
                        avatar: state.articleInfo?.user?.avatar ?? '',
                        username: state.articleInfo?.user?.nickname ?? '',
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
              bottomNavigationBar: (!state.isLoading
                  ? _FixedRow(
                      controller: state.commentTextController,
                      commentFocusNode: state.commentFocusNode,
                      dispatch: dispatch,
                      articleDetail: state.articleInfo,
                      isColl: state.isColl,
                      isLike: state.isLike,
                    )
                  : null),
              body: Stack(
                children: [
                  state.isLoading
                      ? LoadingLayout(
                          title: '加载中...',
                          show: true,
                        )
                      : viewService.buildComponent('decorateArticle'),
                  // _CommentWidget(
                  //   avatar: state.avatar,
                  //   commentList: state.articleInfo.comments,
                  //   controller: state.commentTextController,
                  //   commentFocusNode: state.commentFocusNode,
                  //   commentLikeCount: state.commentLikeCount,
                  //   dispatch: dispatch,
                  // ),
                ],
              ));
          break;
      }
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
      // margin: EdgeInsets.only(left: Adapt.width(120)),
      width: Adapt.width(500),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.horizontal,
        children: [
          // 用户头像
          Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: Adapt.width(20)),
                child: ClipOval(
                  child: Image.network(
                    avatar,
                    fit: BoxFit.cover,
                    // width: 35,
                    // height: 35,
                    // color: Colors.black
                  ),
                ),
              )),
          // Expanded(
          //     flex: 1,
          //     child: SizedBox(
          //       width: Adapt.width(5),
          //     )),
          Expanded(
              flex: 6,
              child: Text(
                username,
                style: TextStyle(
                    fontSize: Adapt.sp(32),
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )),
          Expanded(
              flex: 2,
              child: Container(
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
              )),
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
            style: TextStyle(fontSize: Adapt.sp(36), letterSpacing: 1.0),
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
  final TextEditingController controller;
  final ArticleDetail articleDetail;
  final FocusNode commentFocusNode;
  final Dispatch dispatch;
  final bool isLike;
  final bool isColl;
  const _FixedRow(
      {this.controller,
      this.commentFocusNode,
      this.dispatch,
      this.isLike,
      this.isColl,
      this.articleDetail});
  @override
  Widget build(BuildContext context) {
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
                child: TextField(
                  onSubmitted: (s) =>
                      {dispatch(ArticleDetailActionCreator.pubilshComment())},
                  controller: controller,
                  onEditingComplete: () =>
                      {dispatch(ArticleDetailActionCreator.completeComment())},
                  focusNode: commentFocusNode,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(Adapt.width(20),
                        Adapt.height(5), Adapt.width(10), Adapt.height(28)),
                    border: InputBorder.none,
                    hintText: "评论一下...",
                    hintStyle: TextStyle(
                      fontSize: Adapt.sp(30),
                      height: Adapt.height(2),
                    ),
                  ),
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
                      child: isLike
                          ? IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red[400],
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        ArticleDetailActionCreator.cancelLike())
                                  })
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        ArticleDetailActionCreator.likeHandle())
                                  }),
                    ),
                    Text(
                      articleDetail?.like.toString(),
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
                      child: isColl
                          ? IconButton(
                              icon: Icon(
                                Icons.star,
                                color: Colors.red[400],
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        ArticleDetailActionCreator.cancelColl())
                                  })
                          : IconButton(
                              icon: Icon(
                                Icons.star_border_outlined,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        ArticleDetailActionCreator.collHandle())
                                  }),
                    ),
                    Text(
                      articleDetail?.coll.toString(),
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
                      articleDetail?.comments?.length.toString(),
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
  final List commentList;
  final String avatar;
  final TextEditingController controller;
  final FocusNode commentFocusNode;
  final Dispatch dispatch;
  final int commentLikeCount;
  const _CommentWidget(
      {this.avatar,
      this.commentList,
      this.controller,
      this.commentFocusNode,
      this.dispatch,
      this.commentLikeCount});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(30), 0, Adapt.width(30), 0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '共 ${commentList.length} 条评论',
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
                        borderRadius: BorderRadius.circular(Adapt.radius(50))),
                    height: Adapt.height(60),
                    child: TextField(
                      onSubmitted: (s) => {
                        dispatch(ArticleDetailActionCreator.pubilshComment())
                      },
                      controller: controller,
                      focusNode: commentFocusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(Adapt.width(20),
                            Adapt.height(5), Adapt.width(10), Adapt.height(27)),
                        border: InputBorder.none,
                        hintText: "评论一下...",
                        hintStyle: TextStyle(
                          fontSize: Adapt.sp(30),
                          height: Adapt.height(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _CommentListWidget(
            commentList: commentList,
            dispatch: dispatch,
            commentLikeCount: commentLikeCount,
          )
        ],
      ),
    );
  }
}

class _CommentListWidget extends StatelessWidget {
  final List<Comments> commentList;
  final Dispatch dispatch;
  final int commentLikeCount;
  const _CommentListWidget(
      {this.commentList, this.dispatch, this.commentLikeCount});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, Adapt.height(20), 0, Adapt.height(20)),
      child: ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: commentList.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
                height: Adapt.height(30),
                color: Color(0xFFFFFFFF),
              ),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onLongPress: () => {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: Adapt.height(400),
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.delete_outline),
                              title: Text("删除"),
                              onTap: () => {
                                dispatch(
                                    ArticleDetailActionCreator.deleteComment(
                                        commentList[index].cid))
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.copy),
                              title: Text("复制"),
                              onTap: () => Navigator.pop(context),
                            ),
                            ListTile(
                              leading:
                                  Icon(Icons.report_gmailerrorred_outlined),
                              title: Text("举报"),
                              onTap: () => {
                                Fluttertoast.showToast(msg: '举报成功！'),
                                Navigator.pop(context)
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.cancel_outlined),
                              title: Text("取消"),
                              onTap: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      );
                    })
              },
              child: Container(
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
                              commentList[index].user?.avatar,
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
                            flex: 8,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${commentList[index].user?.nickname ?? commentList[index].user?.username}' ??
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
                                    Expanded(
                                      child: Text(
                                          '${commentList[index].content}' ??
                                              'test'),
                                    ),
                                    Text(
                                      '03-16',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Adapt.sp(24)),
                                    ),
                                    SizedBox(
                                      width: Adapt.width(20),
                                    ),
                                  ],
                                )
                              ],
                            )),
                        // Expanded(
                        //   flex: 1,
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         margin: EdgeInsets.fromLTRB(
                        //             0, 0, Adapt.width(25), Adapt.width(10)),
                        //         width: Adapt.width(40),
                        //         height: Adapt.height(40),
                        //         child: IconButton(
                        //             icon: Icon(
                        //               Icons.favorite_border,
                        //               size: Adapt.height(30),
                        //               color: commentLikeCount > 1
                        //                   ? Colors.red
                        //                   : '',
                        //             ),
                        //             onPressed: () => {
                        //                   dispatch(ArticleDetailActionCreator
                        //                       .likeComment(
                        //                           commentList[index].cid))
                        //                 }),
                        //       ),
                        //       // SizedBox(
                        //       //   height: Adapt.height(5),
                        //       // ),
                        //       Text(
                        //         commentLikeCount.toString(),
                        //         style: TextStyle(
                        //             color: Colors.black54,
                        //             fontSize: Adapt.sp(24)),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ])),
            );
          }),
    );
  }
}
