import 'package:bluespace/components/CustomReorderableListView.dart';
import 'package:bluespace/pages/decorate_page/action.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HouseDetailState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    margin: EdgeInsets.all(Adapt.height(10)),
    width: Adapt.screenW(),
    // height: Adapt.screenH(),
    child: SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
              onTap: () =>
                  {dispatch(HouseDetailActionCreator.setTitlePicture())},
              child: Stack(
                children: [
                  state.titleImage != null
                      ? Container(
                          width: Adapt.screenW(),
                          height: Adapt.height(300),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetThumbImageProvider(
                                      state.titleImage,
                                      width: Adapt.screenW().toInt(),
                                      height: Adapt.height(300).toInt()))),
                        )
                      : Container(),
                  Container(
                    width: Adapt.screenW(),
                    height: Adapt.height(300),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, color: Colors.white),
                        SizedBox(
                          height: Adapt.height(10),
                        ),
                        Text(
                          state.titleImage != null ? '修改封面' : '请选择封面图',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: Adapt.height(10),
          ),
          Container(
            height: Adapt.height(80),
            child: Row(children: [
              Icon(Icons.new_releases_rounded,
                  color: Colors.red, size: Adapt.height(15)),
              SizedBox(
                width: Adapt.width(30),
              ),
              Text(
                '标题',
                style: TextStyle(
                    fontSize: Adapt.sp(36), fontWeight: FontWeight.w400),
              )
            ]),
          ),
          SizedBox(
            height: Adapt.height(10),
          ),
          Divider(
            height: Adapt.height(2),
            color: Colors.grey,
          ),
          SizedBox(
            height: Adapt.height(30),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey[200], width: Adapt.height(3)))),
              padding: EdgeInsets.only(bottom: Adapt.height(15)),
              width: Adapt.screenW() - Adapt.width(100),
              child: TextField(
                controller: state.titleController,
                onSubmitted: (s) =>
                    dispatch(DecorateActionCreator.publishArticle()),
                style: TextStyle(color: Colors.black),
                maxLength: 30,
                decoration: InputDecoration(
                    helperText: '至多输入30字',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: '标题',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              )),
          SizedBox(
            height: Adapt.height(10),
          ),
          Container(
            height: Adapt.height(80),
            child: Row(children: [
              Icon(Icons.new_releases_rounded,
                  color: Colors.red, size: Adapt.height(15)),
              SizedBox(
                width: Adapt.width(30),
              ),
              Text(
                '介绍',
                style: TextStyle(
                    fontSize: Adapt.sp(36), fontWeight: FontWeight.w400),
              )
            ]),
          ),
          SizedBox(
            height: Adapt.height(10),
          ),
          Divider(
            height: Adapt.height(2),
            color: Colors.grey,
          ),
          SizedBox(
            height: Adapt.height(30),
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Colors.grey[200], width: Adapt.height(3)))),
              padding: EdgeInsets.only(bottom: Adapt.height(15)),
              width: Adapt.screenW() - Adapt.width(100),
              child: TextField(
                controller: state.detailController,
                style: TextStyle(color: Colors.black),
                maxLength: 300,
                maxLines: 3,
                decoration: InputDecoration(
                    helperText: '至多输入300字',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    labelText: '介绍',
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
              )),
          Container(
            height: Adapt.height(80),
            child: Row(children: [
              Icon(Icons.new_releases_rounded,
                  color: Colors.red, size: Adapt.height(15)),
              SizedBox(
                width: Adapt.width(30),
              ),
              Text(
                '房间',
                style: TextStyle(
                    fontSize: Adapt.sp(36), fontWeight: FontWeight.w400),
              )
            ]),
          ),
          SizedBox(
            height: Adapt.height(10),
          ),
          Divider(
            height: Adapt.height(2),
            color: Colors.grey,
          ),
          CustomReorderableListView(list: [
            _SpaceList(
              title: '户型图',
              subtitle: '请上传户型图并写下描述',
              controller: state.houseTypeController,
              imgs: state.houseTypeImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('houseType')),
            ),
            _SpaceList(
              title: '客厅',
              subtitle: '请上传客厅图并写下描述',
              controller: state.parlourController,
              imgs: state.parlourImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('parlour')),
            ),
            _SpaceList(
              title: '厨房',
              subtitle: '请上传厨房图并写下描述',
              controller: state.kitchenController,
              imgs: state.kitchenImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('kitchen')),
            ),
            _SpaceList(
              title: '主卧',
              subtitle: '请上传主卧图并写下描述',
              controller: state.masterBedroomController,
              imgs: state.masterBedroomImages,
              onTap: () => dispatch(
                  HouseDetailActionCreator.selectImgs('masterBedroom')),
            ),
            _SpaceList(
              title: '次卧',
              subtitle: '请上传次卧图并写下描述',
              controller: state.secondBedroomController,
              imgs: state.secondBedroomImages,
              onTap: () => dispatch(
                  HouseDetailActionCreator.selectImgs('secondBedroom')),
            ),
            _SpaceList(
              title: '卫生间',
              subtitle: '请上传卫生间图并写下描述',
              controller: state.toiletController,
              imgs: state.toiletImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('toilet')),
            ),
            _SpaceList(
              title: '书房',
              subtitle: '请上传书房图并写下描述',
              controller: state.studyRoomController,
              imgs: state.studyRoomImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('studyRoom')),
            ),
            _SpaceList(
              title: '阳台',
              subtitle: '请上传阳台图并写下描述',
              controller: state.balconyController,
              imgs: state.balconyImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('balcony')),
            ),
            _SpaceList(
              title: '走廊',
              subtitle: '请上传走廊图并写下描述',
              controller: state.corridorController,
              imgs: state.corridorImages,
              onTap: () =>
                  dispatch(HouseDetailActionCreator.selectImgs('corridor')),
            ),
          ])
        ],
      ),
    ),
  );
}

class _SpaceList extends StatelessWidget {
  final String title;
  final List<Asset> imgs;
  final Function onTap;
  final String subtitle;
  final TextEditingController controller;
  final bool isShow;
  const _SpaceList({
    this.imgs,
    this.onTap,
    this.title,
    this.subtitle,
    this.controller,
    this.isShow,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, Adapt.height(20), 0, Adapt.height(20)),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))),
        child: Column(
          children: [
            Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    flex: 2,
                    child: GestureDetector(
                      child: Icon(
                        Icons.swap_vert_circle_outlined,
                        color: Colors.black54,
                        size: Adapt.height(50),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: Adapt.sp(32), fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    flex: 10,
                    child: imgs != null
                        ? Container(
                            height: Adapt.height(80),
                            child: Row(
                              children: [
                                ListView(
                                  reverse: true,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: imgs
                                      .map((asset) => Container(
                                            margin: EdgeInsets.fromLTRB(
                                                Adapt.width(10),
                                                0,
                                                Adapt.width(10),
                                                0),
                                            child: AssetThumb(
                                              asset: asset,
                                              width: 100,
                                              height: 100,
                                            ),
                                          ))
                                      .toList(),
                                ),
                                imgs.length >= 4
                                    ? Container()
                                    : InkWell(
                                        onTap: onTap,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              padding: EdgeInsets.all(
                                                  Adapt.height(10)),
                                              child: Icon(
                                                Icons.add,
                                                size: Adapt.height(60),
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                              ],
                            ))
                        : InkWell(
                            onTap: onTap,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  padding: EdgeInsets.all(Adapt.height(10)),
                                  child: Icon(
                                    Icons.add,
                                    size: Adapt.height(50),
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  width: Adapt.width(20),
                                ),
                              ],
                            ),
                          )),
              ],
            ),
            SizedBox(
              height: Adapt.height(20),
            ),
            Container(
              margin: EdgeInsets.only(bottom: Adapt.height(0)),
              padding: EdgeInsets.symmetric(horizontal: Adapt.width(15)),
              // height: _heightAnimation.value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Adapt.radius(15)),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    // height: Adapt.height(300),
                    width: Adapt.screenW() - Adapt.width(60),
                    child: TextField(
                      controller: controller,
                      maxLines: 1,
                      maxLength: 300,
                      decoration: InputDecoration(
                          helperText: '至多输入300字',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          labelText: '图片描述',
                          labelStyle: TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
