import 'dart:io';

import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PublishState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFEDF6FD),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark,
          child: Stack(
            children: <Widget>[
              _AppBar(),
              Positioned(
                top: Adapt.px(100),
                right: 15.0,
                child: Container(
                  width: Adapt.px(120),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: TextButton(
                    onPressed: () =>
                        {dispatch(PublishActionCreator.onPublish())},
                    child: Center(
                      child: Text(
                        "发布",
                        style: TextStyle(
                            fontSize: Adapt.px(32),
                            // fontWeight: FontWeight.bold,
                            // letterSpacing: Adapt.px(10),
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Adapt.px(200)),
                child: _ImagePanel(
                  dispatch: dispatch,
                  images: state.images,
                  onPublish: (s) => dispatch(PublishActionCreator.onPublish()),
                  titleFocusNode: state.titleFocusNode,
                  titleTextController: state.titleTextController,
                  contentFocusNode: state.contentFocusNode,
                  contentTextController: state.contentTextController,
                ),
              )
            ],
          ),
        ));
  });
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}

class _ImagePanel extends StatelessWidget {
  final TextEditingController titleTextController;
  final TextEditingController contentTextController;
  final FocusNode titleFocusNode;
  final FocusNode contentFocusNode;
  final Dispatch dispatch;
  final List<Asset> images;
  final Function(String) onPublish;
  const _ImagePanel(
      {this.dispatch,
      this.images,
      this.titleTextController,
      this.contentTextController,
      this.titleFocusNode,
      this.contentFocusNode,
      this.onPublish});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(Adapt.px(30)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: TextField(
                controller: titleTextController,
                focusNode: titleFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                maxLength: 10,
                decoration: InputDecoration.collapsed(
                  hintText: '写下图片的标题~',
                  hintStyle: TextStyle(
                      fontSize: Adapt.px(36), fontWeight: FontWeight.bold),
                ),
                onSubmitted: (s) {
                  titleFocusNode.nextFocus();
                },
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: TextField(
                focusNode: contentFocusNode,
                controller: contentTextController,
                maxLines: 3,
                maxLength: 30,
                decoration: InputDecoration.collapsed(
                  hintText: '写下图片的介绍~',
                ),
                onSubmitted: onPublish,
              ),
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        Adapt.px(30), 0, Adapt.px(30), Adapt.px(80)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Adapt.px(20))),
                    child: images.length <= 0
                        ? Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: Adapt.px(80)),
                                width: Adapt.px(200),
                                height: Adapt.px(200),
                                child: InkWell(
                                  onTap: () => {
                                    dispatch(
                                        PublishActionCreator.onOpenGallery())
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.blueGrey)),
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
                                                dispatch(PublishActionCreator
                                                    .onOpenGallery())
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.blueGrey)),
                                                child: Icon(Icons.add),
                                              ),
                                            ));
                            }),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
          ],
        ));
  }
}
