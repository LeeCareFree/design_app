import 'package:bluespace/components/loading.dart';
import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/pages/article_detail_page/view.dart';
import 'package:bluespace/pages/video_page/component/buttonRow.dart';
import 'package:bluespace/pages/video_page/component/video_comp.dart';
import 'package:bluespace/pages/video_page/component/videoScaffold.dart';
import 'package:bluespace/router/PopRouter.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VideoState state, Dispatch dispatch, ViewService viewService) {
  double a = MediaQuery.of(viewService.context).size.aspectRatio;
  bool hasBottomPadding = a < 0.55;
  return Scaffold(
    // controller: state.tkController,
    // hasBottomPadding: false,
    appBar: AppBar(
      backgroundColor: Colors.black,
      elevation: 1.0,
      centerTitle: true,
      actions: [
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () => {
                  showModalBottomSheet(
                      context: viewService.context,
                      builder: (context) {
                        return Container(
                          height: state.uid == state.articleInfo?.user?.uid
                              ? Adapt.height(200)
                              : Adapt.height(100),
                          child: Column(
                            children: <Widget>[
                              state.uid == state.articleInfo?.user?.uid
                                  ? ListTile(
                                      leading: Icon(
                                          Icons.report_gmailerrorred_outlined),
                                      title: Text("删除文章"),
                                      onTap: () => {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text("提示"),
                                                  content: Text("确定要删除这篇文章吗？"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text(
                                                        "取消",
                                                      ),
                                                      onPressed: () => {
                                                        Navigator.pop(context),
                                                        Navigator.pop(context),
                                                      },
                                                    ),
                                                    TextButton(
                                                        child: Text(
                                                          "确定",
                                                        ),
                                                        onPressed: () => {
                                                              dispatch(
                                                                  VideoActionCreator
                                                                      .deleteArticle()),
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
    bottomNavigationBar: _FixedRow(
      controller: state.commentTextController,
      commentFocusNode: state.commentFocusNode,
      dispatch: dispatch,
      articleDetail: state.articleInfo,
      isColl: state.isColl,
      isLike: state.isLike,
      uid: state.uid,
    ),
    body: state.isLoading
        ? LoadingLayout(
            title: '加载中...',
            show: true,
          )
        : Stack(
            // index: currentPage == null ? 0 : 1,
            children: <Widget>[
              PageView.builder(
                key: Key('home'),
                controller: state.pageController,
                pageSnapping: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: state.videoListController.videoCount,
                itemBuilder: (context, i) {
                  // 拼一个视频组件出来
                  var data = state.videoList[i];
                  // bool isF = SafeMap(favoriteMap)[i].boolean ?? false;
                  var player = state.videoListController.playerOfIndex(i);
                  // video
                  Widget currentVideo = FijkView(
                    fit: FijkFit.fitHeight,
                    player: player,
                    color: Colors.black,
                    panelBuilder: (_, __, ___, ____, _____) => Container(),
                  );

                  currentVideo = VideoPage(
                    hidePauseIcon: player.state != FijkState.paused,
                    aspectRatio: 9 / 16.0,
                    key: Key(data.videoUrl + '$i'),
                    tag: data.videoUrl,
                    userInfoWidget: VideoUserInfo(
                      desc: data.detail, userInfo: state.articleInfo?.user,
                      // onGoodGift: () => showDialog(
                      //   context: context,
                      //   builder: (_) => FreeGiftDialog(),
                      // ),
                    ),
                    onSingleTap: () async {
                      if (player.state == FijkState.started) {
                        await player.pause();
                      } else {
                        await player.start();
                      }
                    },
                    onAddFavorite: () {},
                    video: currentVideo,
                  );
                  return currentVideo;
                },
              ),
              // Center(
              //   child: Text(_currentIndex.toString()),
              // )
            ],
          ),
  );
}

class _FixedRow extends StatelessWidget {
  final TextEditingController controller;
  final ArticleInfo articleDetail;
  final FocusNode commentFocusNode;
  final Dispatch dispatch;
  final bool isLike;
  final bool isColl;
  final String uid;
  const _FixedRow(
      {this.controller,
      this.uid,
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
            color: Colors.black,
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
                            dispatch(VideoActionCreator.publishComment()),
                            Navigator.pop(context)
                          },
                        )))
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Adapt.width(30)),
                    decoration: BoxDecoration(
                        color: Colors.white,
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
                          style: TextStyle(color: Colors.black),
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
                                        VideoActionCreator.likeHandle('cancel'))
                                  })
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        VideoActionCreator.likeHandle('like'))
                                  }),
                    ),
                    Text(
                      articleDetail?.like.toString(),
                      style: TextStyle(
                          fontSize: Adapt.sp(28), color: Colors.white),
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
                                        VideoActionCreator.collHandle('cancel'))
                                  })
                          : IconButton(
                              icon: Icon(
                                Icons.star_border_outlined,
                                color: Colors.white,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {
                                    dispatch(
                                        VideoActionCreator.collHandle('coll'))
                                  }),
                    ),
                    Text(
                      articleDetail?.coll.toString(),
                      style: TextStyle(
                          fontSize: Adapt.sp(28), color: Colors.white),
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
                            color: Colors.white,
                            size: Adapt.height(50),
                          ),
                          onPressed: () => {
                                showBottomSheet(
                                  backgroundColor: Colors.white.withOpacity(0),
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CommentBottomSheet(
                                    commentList: articleDetail?.comments,
                                    uid: uid,
                                    dispatch: dispatch,
                                  ),
                                )
                              }),
                    ),
                    Text(
                      articleDetail?.comments?.length.toString(),
                      style: TextStyle(
                          fontSize: Adapt.sp(28), color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class CommentBottomSheet extends StatelessWidget {
  final List<Comments> commentList;
  final bool isSelf;
  final String uid;
  final Dispatch dispatch;
  const CommentBottomSheet({
    this.uid,
    this.commentList,
    this.dispatch,
    this.isSelf,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.screenH() / 2,
      // margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(Adapt.height(5)),
            height: Adapt.height(5),
            width: Adapt.width(40),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Container(
            height: Adapt.height(50),
            alignment: Alignment.center,
            // color: Colors.white.withOpacity(0.2),
            child: Text(
              '共${commentList?.length}条评论',
            ),
          ),
          Expanded(
            child: ListView(
              children: commentList
                  .map((e) => _CommentRow(
                        comment: e,
                        isSelf: uid == e.uid,
                        dispatch: dispatch,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentRow extends StatelessWidget {
  final Comments comment;
  final bool isSelf;
  final Dispatch dispatch;
  const _CommentRow({
    this.comment,
    this.dispatch,
    this.isSelf,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                height: isSelf ? Adapt.height(400) : Adapt.height(300),
                child: Column(
                  children: <Widget>[
                    isSelf
                        ? ListTile(
                            leading: Icon(Icons.delete_outline),
                            title: Text("删除"),
                            onTap: () => {
                              dispatch(
                                  VideoActionCreator.deleteComment(comment.cid))
                            },
                          )
                        : Container(),
                    ListTile(
                      leading: Icon(Icons.copy),
                      title: Text("复制"),
                      onTap: () => Navigator.pop(context),
                    ),
                    ListTile(
                      leading: Icon(Icons.report_gmailerrorred_outlined),
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
                  bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () => {
                        Navigator.of(context).pushNamed('personalPage',
                            arguments: {'uid': comment?.user?.uid})
                      },
                      child: ClipOval(
                        child: Image.network(
                          comment?.user?.avatar,
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
                              '${comment?.user?.nickname ?? comment?.user?.username}' ??
                                  'test',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: Adapt.sp(24)),
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
                              child: Text('${comment?.content}' ?? 'test'),
                            ),
                            Text(
                              '${comment?.commenttime}',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: Adapt.sp(24)),
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
  }
}
