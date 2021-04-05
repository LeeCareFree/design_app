import 'dart:ui';

import 'package:bluespace/components/asperctRaioImage.dart';
import 'package:bluespace/components/loading.dart';
import 'package:bluespace/components/swiperPanel.dart';
import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/router/PopRouter.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                state.isFollow != null
                    ? Row(
                        children: [
                          _UserInfoWidget(
                            avatar: state.articleInfo?.user?.avatar ?? '',
                            username: state.articleInfo?.user?.nickname ?? '',
                            dispatch: dispatch,
                            isFollow: state.isFollow ?? false,
                            isSelf: state.uid == state.articleInfo?.user?.uid,
                            theme: _theme,
                          ),
                        ],
                      )
                    : Container(),
                IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () => {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height:
                                      state.uid == state.articleInfo?.user?.uid
                                          ? Adapt.height(200)
                                          : Adapt.height(100),
                                  child: Column(
                                    children: <Widget>[
                                      state.uid == state.articleInfo?.user?.uid
                                          ? ListTile(
                                              leading: Icon(Icons
                                                  .report_gmailerrorred_outlined),
                                              title: Text("删除文章"),
                                              onTap: () => {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text("提示"),
                                                          content: Text(
                                                              "确定要删除这篇文章吗？"),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                "取消",
                                                              ),
                                                              onPressed: () => {
                                                                Navigator.pop(
                                                                    context),
                                                                Navigator.pop(
                                                                    context),
                                                              },
                                                            ),
                                                            TextButton(
                                                                child: Text(
                                                                  "确定",
                                                                ),
                                                                onPressed:
                                                                    () => {
                                                                          dispatch(
                                                                              ArticleDetailActionCreator.deleteArticle()),
                                                                        }),
                                                          ],
                                                        );
                                                      },
                                                    )
                                                  })
                                          : Container(),
                                      ListTile(
                                        leading: Icon(Icons.cancel_outlined),
                                        title: Text("取消"),
                                        onTap: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              })
                        })
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
            body: Stack(children: [
              state.isLoading
                  ? LoadingLayout(
                      title: '加载中...',
                      show: true,
                    )
                  : SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      controller: state.refreshController,
                      onRefresh: () => {
                            dispatch(ArticleDetailActionCreator.getArticle()),
                          },
                      onLoading: () => {},
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                viewService.buildComponent('decorateArticle'),
                                _CommentWidget(
                                  avatar: state.avatar ?? '',
                                  commentList: state.articleInfo.comments,
                                  controller: state.commentTextController,
                                  commentFocusNode: state.commentFocusNode,
                                  commentLikeCount: state.commentLikeCount,
                                  isSelf:
                                      state.uid == state.articleInfo?.user?.uid,
                                  dispatch: dispatch,
                                ),
                              ]))
                        ],
                      ))
            ]),
          );
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
                  state.avatar != null
                      ? Row(
                          children: [
                            _UserInfoWidget(
                              avatar: state.articleInfo?.user?.avatar ?? '',
                              username: state.articleInfo?.user?.nickname ?? '',
                              dispatch: dispatch,
                              isFollow: state.isFollow ?? false,
                              isSelf: state.uid == state.articleInfo?.user?.uid,
                              theme: _theme,
                            ),
                          ],
                        )
                      : Container(),
                  IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: state.uid ==
                                            state.articleInfo?.user?.uid
                                        ? Adapt.height(200)
                                        : Adapt.height(100),
                                    child: Column(
                                      children: <Widget>[
                                        state.uid ==
                                                state.articleInfo?.user?.uid
                                            ? ListTile(
                                                leading: Icon(Icons
                                                    .report_gmailerrorred_outlined),
                                                title: Text("删除文章"),
                                                onTap: () => {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text("提示"),
                                                            content: Text(
                                                                "确定要删除这篇文章吗？"),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: Text(
                                                                  "取消",
                                                                ),
                                                                onPressed: () =>
                                                                    {
                                                                  Navigator.pop(
                                                                      context),
                                                                  Navigator.pop(
                                                                      context),
                                                                },
                                                              ),
                                                              TextButton(
                                                                  child: Text(
                                                                    "确定",
                                                                  ),
                                                                  onPressed:
                                                                      () => {
                                                                            dispatch(ArticleDetailActionCreator.deleteArticle()),
                                                                          }),
                                                            ],
                                                          );
                                                        },
                                                      )
                                                    })
                                            : Container(),
                                        ListTile(
                                          leading: Icon(Icons.cancel_outlined),
                                          title: Text("取消"),
                                          onTap: () => Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                          })
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
              body: Stack(children: [
                state.isLoading
                    ? LoadingLayout(
                        title: '加载中...',
                        show: true,
                      )
                    : SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: state.refreshController,
                        onRefresh: () => {
                              dispatch(ArticleDetailActionCreator.getArticle()),
                            },
                        child: CustomScrollView(
                          physics: BouncingScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  SwiperPanel(
                                    backdrops: state.articleInfo.imgList,
                                  ),
                                  _ArticleWidget(
                                    title: state.articleInfo.title,
                                    content: state.articleInfo.detail,
                                    time: state.articleInfo.createtime,
                                  ),
                                  _CommentWidget(
                                    avatar: state.avatar ?? '',
                                    commentList: state.articleInfo.comments,
                                    controller: state.commentTextController,
                                    commentFocusNode: state.commentFocusNode,
                                    commentLikeCount: state.commentLikeCount,
                                    dispatch: dispatch,
                                  ),
                                ]))
                          ],
                        ))
              ]));
          break;
      }
    },
  );
}

class _UserInfoWidget extends StatelessWidget {
  final String username;
  final String avatar;
  final theme;
  final Dispatch dispatch;
  final bool isFollow;
  final bool isSelf;
  const _UserInfoWidget(
      {this.username,
      this.avatar,
      this.theme,
      this.dispatch,
      this.isFollow,
      this.isSelf});
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
                child: CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                  radius: Adapt.width(50),
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
              flex: 3,
              child: Container(
                child: isSelf
                    ? Container()
                    : Container(
                        height: Adapt.height(55),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueGrey),
                            borderRadius:
                                BorderRadius.circular(Adapt.radius(50))),
                        child: isFollow
                            ? TextButton(
                                onPressed: () => {
                                      dispatch(
                                          ArticleDetailActionCreator.follow(
                                              'cancel'))
                                    },
                                child: Text(
                                  "已关注",
                                  style: TextStyle(
                                      fontSize: Adapt.sp(24),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: Adapt.px(10),
                                      color: Colors.grey[600]),
                                ))
                            : TextButton(
                                onPressed: () => {
                                      dispatch(
                                          ArticleDetailActionCreator.follow(
                                              'add'))
                                    },
                                child: Text(
                                  "关注",
                                  style: TextStyle(
                                      fontSize: Adapt.sp(24),
                                      fontWeight: FontWeight.bold,
                                      // letterSpacing: Adapt.px(10),
                                      color: Colors.blueGrey),
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
  final ArticleInfo articleDetail;
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
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        PopRoute(
                            child: BottomInputDialog(
                          textEditingController: controller,
                          submit: () => {
                            dispatch(
                                ArticleDetailActionCreator.pubilshComment()),
                            Navigator.pop(context)
                          },
                        )))
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Adapt.width(30)),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Adapt.radius(50))),
                    height: Adapt.height(60),
                    child: Row(
                      children: [
                        SizedBox(
                          width: Adapt.width(20),
                        ),
                        Text(
                          '评论一下吧~',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                )),
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
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    PopRoute(
                                        child: BottomInputDialog(
                                      textEditingController: controller,
                                      submit: () => {
                                        dispatch(ArticleDetailActionCreator
                                            .pubilshComment()),
                                        Navigator.pop(context)
                                      },
                                    )))
                              }),
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
  final bool isSelf;
  const _CommentWidget(
      {this.avatar,
      this.commentList,
      this.controller,
      this.commentFocusNode,
      this.dispatch,
      this.commentLikeCount,
      this.isSelf});
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
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(
                            context,
                            PopRoute(
                                child: BottomInputDialog(
                              textEditingController: controller,
                              submit: () => {
                                dispatch(ArticleDetailActionCreator
                                    .pubilshComment()),
                                Navigator.pop(context)
                              },
                            )))
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Adapt.width(30)),
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                BorderRadius.circular(Adapt.radius(50))),
                        height: Adapt.height(60),
                        child: Row(
                          children: [
                            SizedBox(
                              width: Adapt.width(20),
                            ),
                            Text(
                              '评论一下吧~',
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
          _CommentListWidget(
            commentList: commentList,
            dispatch: dispatch,
            commentLikeCount: commentLikeCount,
            isSelf: isSelf,
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
  final bool isSelf;
  const _CommentListWidget(
      {this.commentList, this.dispatch, this.commentLikeCount, this.isSelf});
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
                        height: isSelf ? Adapt.height(300) : Adapt.height(400),
                        child: Column(
                          children: <Widget>[
                            isSelf
                                ? Container()
                                : ListTile(
                                    leading: Icon(Icons.delete_outline),
                                    title: Text("删除"),
                                    onTap: () => {
                                      dispatch(ArticleDetailActionCreator
                                          .deleteComment(
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
                            child: InkWell(
                              onTap: () => {
                                Navigator.of(context).pushNamed('personalPage',
                                    arguments: {
                                      'uid': commentList[index].user?.uid
                                    })
                              },
                              child: ClipOval(
                                child: Image.network(
                                  commentList[index].user?.avatar,
                                  fit: BoxFit.cover,
                                  width: 35,
                                  height: 35,
                                  // color: Colors.black
                                ),
                              ),
                            )),
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
                      ])),
            );
          }),
    );
  }
}

class BottomInputDialog extends StatelessWidget {
  final TextEditingController textEditingController;
  final String type;
  final Function submit;
  const BottomInputDialog({this.textEditingController, this.type, this.submit});
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: new GestureDetector(
            child: new Container(
              color: Colors.black54,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
          Container(
            width: Adapt.screenW(),
            decoration: BoxDecoration(color: Colors.grey[50]),
            child: Flex(
              direction: Axis.horizontal,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.only(left: Adapt.width(30)),
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(Adapt.radius(50))),
                    height: Adapt.height(60),
                    child: TextField(
                      onSubmitted: (s) => submit(),
                      controller: textEditingController,
                      autofocus: true,
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
                Expanded(
                  flex: 1,
                  child: TextButton(onPressed: submit, child: Text('发布')),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
