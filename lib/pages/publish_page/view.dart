import 'dart:io';

import 'package:bluespace/components/videoCell.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PublishState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Color.fromRGBO(176, 213, 223, 1),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            Container(
              margin: EdgeInsets.fromLTRB(
                  0, Adapt.height(15), Adapt.height(15), Adapt.height(20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.radius(50)),
                  color: Colors.blueGrey),
              child: TextButton(
                  onPressed: () => {dispatch(PublishActionCreator.onPublish())},
                  child: Text(
                    '发布',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: _theme.brightness == Brightness.light
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
            child: Container(
              child: _ImagePanel(
                dispatch: dispatch,
                images: state.images,
                video: state.video,
                chewieController: state.chewieController,
                onPublish: (s) => dispatch(PublishActionCreator.onPublish()),
                titleFocusNode: state.titleFocusNode,
                titleTextController: state.titleTextController,
                contentFocusNode: state.contentFocusNode,
                contentTextController: state.contentTextController,
              ),
            )));
  });
}

class _ImagePanel extends StatelessWidget {
  final TextEditingController titleTextController;
  final TextEditingController contentTextController;
  final FocusNode titleFocusNode;
  final FocusNode contentFocusNode;
  final Dispatch dispatch;
  final List<Asset> images;
  final Function(String) onPublish;
  final File video;
  final ChewieController chewieController;
  const _ImagePanel(
      {this.dispatch,
      this.images,
      this.titleTextController,
      this.contentTextController,
      this.titleFocusNode,
      this.contentFocusNode,
      this.onPublish,
      this.video,
      this.chewieController});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(Adapt.height(30)),
        child: Column(
          children: [
            video != null
                ? Expanded(
                    child: Chewie(controller: chewieController),
                  )
                : Container(),
            images != null
                ? Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(
                            Adapt.width(30),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(Adapt.radius(20))),
                          child: images.length <= 0
                              ? Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: Adapt.height(80)),
                                      width: Adapt.width(200),
                                      height: Adapt.height(200),
                                      child: InkWell(
                                        onTap: () => {
                                          dispatch(PublishActionCreator
                                              .onOpenGallery())
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.blueGrey)),
                                          child: Icon(Icons.add),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : GridView.builder(
                                  // controller: state.,
                                  shrinkWrap: true,
                                  itemCount: images.length,
                                  // SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          // 横轴元素个数
                                          crossAxisCount: 3,
                                          // 纵轴间距
                                          mainAxisSpacing: 10.0,
                                          // 横轴间距
                                          crossAxisSpacing: 10.0,
                                          // 子组件宽高长度比例
                                          childAspectRatio: 1.0),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () => {
                                              dispatch(PublishActionCreator
                                                  .onOpenGallery())
                                            },
                                        child: index + 1 != images.length
                                            ? Container(
                                                // margin:
                                                // EdgeInsets.only(bottom: Adapt.px(60)),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                  style: BorderStyle.solid,
                                                  color: Colors.blueGrey,
                                                )),
                                                child: AssetThumb(
                                                  asset: images[index],
                                                  width: 100,
                                                  height: 100,
                                                ))
                                            : (index == 8)
                                                ? Container(
                                                    // margin:
                                                    // EdgeInsets.only(bottom: Adapt.px(60)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                      style: BorderStyle.solid,
                                                      color: Colors.blueGrey,
                                                    )),
                                                    child: AssetThumb(
                                                      asset: images[index],
                                                      width: 100,
                                                      height: 100,
                                                    ))
                                                : InkWell(
                                                    onTap: () => {
                                                      dispatch(
                                                          PublishActionCreator
                                                              .onOpenGallery())
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .blueGrey)),
                                                      child: Icon(Icons.add),
                                                    ),
                                                  ));
                                  }),
                        ),
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              height: Adapt.height(20),
            ),
            Container(
              padding: EdgeInsets.all(Adapt.width(30)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Adapt.radius(20))),
              child: TextField(
                controller: titleTextController,
                focusNode: titleFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration.collapsed(
                  hintText: '写下标题~',
                  hintStyle: TextStyle(
                      fontSize: Adapt.sp(36), fontWeight: FontWeight.bold),
                ),
                onSubmitted: (s) {
                  titleFocusNode.nextFocus();
                },
              ),
            ),
            SizedBox(
              height: Adapt.height(20),
            ),
            Container(
              padding: EdgeInsets.all(Adapt.height(30)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Adapt.radius(20))),
              child: TextField(
                focusNode: contentFocusNode,
                controller: contentTextController,
                maxLines: 6,
                maxLength: 300,
                decoration: InputDecoration.collapsed(
                  hintText: '写下介绍~',
                ),
                onSubmitted: onPublish,
              ),
            ),
            SizedBox(
              height: Adapt.height(20),
            ),
            SizedBox(
              height: Adapt.height(30),
            ),
          ],
        ));
  }
}
