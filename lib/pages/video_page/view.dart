import 'package:bluespace/components/loading.dart';
import 'package:bluespace/models/article_detail.dart';
import 'package:bluespace/pages/article_detail_page/view.dart';
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
        backgroundColor: Color.fromRGBO(92, 123, 139, 1),
        // elevation: 1.0,
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
                                        leading: Icon(Icons
                                            .report_gmailerrorred_outlined),
                                        title: Text("删除文章"),
                                        onTap: () => {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("提示"),
                                                    content:
                                                        Text("确定要删除这篇文章吗？"),
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
              children: [
                FijkView(
                  player: state.player,
                ),
                VideoUserInfo(
                  desc: state.articleInfo.detail,
                  title: state.articleInfo.title,
                  userInfo: state.articleInfo.user,
                )
              ],
            )
      // Container(
      //     width: Adapt.screenW(),
      //     height: Adapt.screenH(),
      //     color: Colors.black,
      //     child: Stack(
      //       // 因为控件ui和视频是重叠的，所以要用定位了
      //       children: <Widget>[
      //         GestureDetector(
      //             // 手势组件
      //             onTap: () {
      //               // 点击显示/隐藏控件ui
      //               dispatch(VideoActionCreator.updateIsShowControl());
      //             },
      //             child: Center(
      //               child: AspectRatio(
      //                 // 加载url成功时，根据视频比例渲染播放器
      //                 aspectRatio:
      //                     state.videoPlayerController.value.aspectRatio,
      //                 child: VideoPlayer(state.videoPlayerController),
      //               ),
      //             )),
      //         Positioned(
      //           // 需要定位
      //           left: 0,
      //           bottom: 0,
      //           child: Offstage(
      //             // 控制是否隐藏
      //             offstage: state.isShowControl,
      //             child: AnimatedOpacity(
      //               // 加入透明度动画
      //               opacity: state.playControlOpacity,
      //               duration: Duration(milliseconds: 300),
      //               child: Container(
      //                   // 底部控件的容器
      //                   width: Adapt.screenW(),
      //                   height: 40,
      //                   decoration: BoxDecoration(
      //                     gradient: LinearGradient(
      //                       // 来点黑色到透明的渐变优雅一下
      //                       begin: Alignment.bottomCenter,
      //                       end: Alignment.topCenter,
      //                       colors: [
      //                         Color.fromRGBO(0, 0, 0, .7),
      //                         Color.fromRGBO(0, 0, 0, .1)
      //                       ],
      //                     ),
      //                   ),
      //                   child: Row(
      //                     // 加载完成时才渲染,flex布局
      //                     children: <Widget>[
      //                       IconButton(
      //                         // 播放按钮
      //                         padding: EdgeInsets.zero,
      //                         iconSize: 26,
      //                         icon: Icon(
      //                           // 根据控制器动态变化播放图标还是暂停
      //                           state.videoPlayerController.value.isPlaying
      //                               ? Icons.pause
      //                               : Icons.play_arrow,
      //                           color: Colors.white,
      //                         ),
      //                         onPressed: () => {
      //                           dispatch(VideoActionCreator.togglePlay())
      //                         },
      //                       ),
      //                       Flexible(
      //                         // 相当于前端的flex: 1
      //                         child: VideoProgressIndicator(
      //                           // 嘻嘻，这是video_player编写好的进度条，直接用就是了~~
      //                           state.videoPlayerController,
      //                           allowScrubbing: true, // 允许手势操作进度条
      //                           padding: EdgeInsets.all(0),
      //                           colors: VideoProgressColors(
      //                             // 配置进度条颜色，也是video_player现成的，直接用
      //                             playedColor: Colors.blueGrey, // 已播放的颜色
      //                             bufferedColor: Color.fromRGBO(
      //                                 255, 255, 255, .5), // 缓存中的颜色
      //                             backgroundColor: Color.fromRGBO(
      //                                 255, 255, 255, .2), // 为缓存的颜色
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         // 播放时间
      //                         margin: EdgeInsets.only(left: 10),
      //                         child: Text(
      //                           // durationToTime是通过Duration转成hh:mm:ss的格式，自己实现。
      //                           '${state.position.inHours}:${state.position.inMinutes.remainder(60)}:${(state.position.inSeconds.remainder(60))}' +
      //                               '/' +
      //                               '${state.videoPlayerController.value.duration.inSeconds}',
      //                           style: TextStyle(color: Colors.white),
      //                         ),
      //                       ),
      //                       IconButton(
      //                         // 全屏/横屏按钮
      //                         padding: EdgeInsets.zero,
      //                         iconSize: 26,
      //                         icon: Icon(
      //                           // 根据当前屏幕方向切换图标
      //                           state.isFull
      //                               ? Icons.fullscreen_exit
      //                               : Icons.fullscreen,
      //                           color: Colors.white,
      //                         ),
      //                         onPressed: () => {
      //                           // 点击切换是否全屏
      //                           dispatch(VideoActionCreator.toggleFull())
      //                         },
      //                       ),
      //                     ],
      //                   )),
      //             ),
      //           ),
      //         ) // 控件ui下半部 看下面
      //       ],
      //     ))
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
            color: Color.fromRGBO(92, 123, 139, 1),
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
                SizedBox(
                  width: Adapt.width(30),
                ),
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

class VideoUserInfo extends StatelessWidget {
  final String desc;
  final String title;
  final User userInfo;
  // final Function onGoodGift;
  const VideoUserInfo(
      {Key key,
      // @required this.onGoodGift,
      this.title,
      this.desc,
      this.userInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
      ),
      margin: EdgeInsets.only(right: 80),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(50.0, 550.0), //阴影xy轴偏移量
            blurRadius: 30.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
            )
      ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userInfo?.avatar),
                radius: Adapt.width(50),
              ),
              SizedBox(width: Adapt.width(30)),
              Text(
                userInfo.nickname,
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: Adapt.width(30)),
              Container(
                  height: Adapt.height(50),
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(Adapt.radius(50))),
                  child: TextButton(
                      onPressed: () => {},
                      child: Text(
                        '关注',
                        style: TextStyle(
                            fontSize: Adapt.sp(24),
                            fontWeight: FontWeight.bold,
                            // letterSpacing: Adapt.px(10),
                            color: Colors.blueGrey),
                      )))
            ],
          ),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
          Padding(
            padding: EdgeInsets.only(left: Adapt.width(20)),
            child: Text(
              title ?? '标题',
              style: TextStyle(color: Colors.white, fontSize: Adapt.sp(32)),
            ),
          ),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
          Padding(
            padding: EdgeInsets.only(left: Adapt.width(20)),
            child: Text(
              desc ?? '标题',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
          Container(height: Adapt.height(10)),
        ],
      ),
    );
  }
}
