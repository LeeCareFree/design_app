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
        )
      ],
    ),
    bottomNavigationBar: _FixedRow(
      controller: state.commentTextController,
      commentFocusNode: state.commentFocusNode,
      dispatch: dispatch,
      articleDetail: state.articleInfo,
      isColl: state.isColl,
      isLike: state.isLike,
    ),
    body: Stack(
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
              key: Key(data.url + '$i'),
              tag: data.url,
              userInfoWidget: VideoUserInfo(desc: data.desc
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
                          submit: () => {Navigator.pop(context)},
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
                              onPressed: () => {})
                          : IconButton(
                              icon: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {}),
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
                              onPressed: () => {})
                          : IconButton(
                              icon: Icon(
                                Icons.star_border_outlined,
                                color: Colors.white,
                                size: Adapt.height(50),
                              ),
                              onPressed: () => {}),
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
                                Navigator.push(
                                    context,
                                    PopRoute(
                                        child: BottomInputDialog(
                                      textEditingController: controller,
                                      submit: () => {Navigator.pop(context)},
                                    )))
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
