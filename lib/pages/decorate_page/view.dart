import 'package:bluespace/components/CustomReorderableListView.dart';
import 'package:bluespace/components/numberKeyboard.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/pages/personal_page/view.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DecorateState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    backgroundColor: _theme.backgroundColor,
    appBar: AppBar(
      iconTheme: _theme.iconTheme,
      backgroundColor: _theme.bottomAppBarColor,
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(
              0, Adapt.height(15), Adapt.height(15), Adapt.height(20)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Adapt.radius(50)),
          ),
          child: TextButton(
              onPressed: () => {},
              child: Text(
                '预览',
                style: TextStyle(color: Colors.black54),
              )),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              0, Adapt.height(15), Adapt.height(15), Adapt.height(20)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.radius(50)),
              color: Colors.blueGrey),
          child: TextButton(
              onPressed: () =>
                  {dispatch(DecorateActionCreator.publishArticle())},
              child: Text(
                '发布',
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    ),
    body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: state.scrollController,
        physics: NeverScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
                child: PreferredSize(
                    preferredSize: Size.fromHeight(40),
                    child: Material(
                      color: Colors.white,
                      child: TabBar(
                        labelColor: Colors.black,
                        controller: state.tabController,
                        indicatorColor: Colors.blueGrey,
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: Adapt.width(80)),
                        unselectedLabelColor: Colors.black45,
                        tabs: <Widget>[
                          Tab(
                            text: '房屋',
                          ),
                          Tab(text: '空间'),
                          Tab(text: '要求'),
                        ],
                      ),
                    ))),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickySizedBoxDelegate(
              child: SizedBox(
                height: Adapt.height(10),
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyDividerDelegate(
              child: Divider(
                thickness: Adapt.height(3),
                height: 3.0,
                indent: 0.0,
                color: Colors.grey[350],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: Adapt.height(10),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: state.tabController,
              children: <Widget>[
                Container(
                    child: SingleChildScrollView(
                  // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      _ListWidget(
                        title: '户型',
                        content: state.houseType,
                        onTap: () => {
                          showDialog(
                            context: viewService.context,
                            builder: (_) => _HouseTypeList(
                              onTap: (d) => {
                                dispatch(
                                    DecorateActionCreator.selectHouseType(d))
                              },
                              selected: state.houseType,
                            ),
                          )
                        },
                      ),
                      _ListWidget(
                        title: '面积',
                        content: state.houseArea,
                        onTap: () => {
                          showDialog(
                              context: viewService.context,
                              builder: (_) => SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    elevation: 0.0,
                                    backgroundColor: Colors.white,
                                    titleTextStyle: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    title: Text('请输入房屋面积',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    children: [
                                      NumberKeyboardActionSheet(
                                        controller: state.numberController,
                                        callback: (text) => dispatch(
                                            DecorateActionCreator
                                                .updataHouseArea(text)),
                                        name: '房屋面积',
                                        unit: '平米',
                                        key: UniqueKey(),
                                      )
                                    ],
                                  ))
                        },
                      ),
                      _ListWidget(
                        title: '位置',
                        content: state.houseLocation,
                        onTap: () => {
                          dispatch(DecorateActionCreator.selectHouseLocation())
                        },
                      ),
                      _ListWidget(
                        title: '预算',
                        content: state.houseBudget,
                        onTap: () => {
                          showDialog(
                              context: viewService.context,
                              builder: (_) => SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    elevation: 0.0,
                                    backgroundColor: Colors.white,
                                    titleTextStyle: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    title: Text('请输入装修预算',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600)),
                                    children: [
                                      NumberKeyboardActionSheet(
                                        controller: state.numberController,
                                        callback: (text) => dispatch(
                                            DecorateActionCreator
                                                .updataHouseBudget(text)),
                                        name: '装修预算',
                                        unit: '万元',
                                        key: UniqueKey(),
                                      )
                                    ],
                                  ))
                        },
                      ),
                      _ListWidget(
                        title: '是否复式',
                        content: state.maisonette,
                        onTap: () => {
                          showDialog(
                            context: viewService.context,
                            builder: (_) => _MaisonetteList(
                              onTap: (d) => {
                                dispatch(
                                    DecorateActionCreator.updateMaisonette(d))
                              },
                              selected: state.maisonette,
                            ),
                          )
                        },
                      ),
                    ],
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(Adapt.height(10)),
                  width: Adapt.screenW(),
                  // height: Adapt.screenH(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () => {
                                  dispatch(
                                      DecorateActionCreator.setTitlePicture())
                                },
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
                                                    width:
                                                        Adapt.screenW().toInt(),
                                                    height: Adapt.height(300)
                                                        .toInt()))),
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
                                      Icon(Icons.camera_alt_outlined,
                                          color: Colors.white),
                                      SizedBox(
                                        height: Adapt.height(10),
                                      ),
                                      Text(
                                        state.titleImage != null
                                            ? '修改封面'
                                            : '请选择封面图',
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
                                  fontSize: Adapt.sp(36),
                                  fontWeight: FontWeight.w400),
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
                                        color: Colors.grey[200],
                                        width: Adapt.height(3)))),
                            padding: EdgeInsets.only(bottom: Adapt.height(15)),
                            width: Adapt.screenW() - Adapt.width(100),
                            child: TextField(
                              controller: state.titleController,
                              onSubmitted: (s) => dispatch(
                                  DecorateActionCreator.publishArticle()),
                              style: TextStyle(color: Colors.black),
                              maxLength: 30,
                              decoration: InputDecoration(
                                  helperText: '至多输入30字',
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  labelText: '标题',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
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
                                  fontSize: Adapt.sp(36),
                                  fontWeight: FontWeight.w400),
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
                                        color: Colors.grey[200],
                                        width: Adapt.height(3)))),
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
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                  labelText: '介绍',
                                  labelStyle: TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black))),
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
                                  fontSize: Adapt.sp(36),
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: Adapt.width(30),
                            ),
                            Text(
                              '请至少添加一个房间',
                              style: TextStyle(color: Colors.grey),
                            ),
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
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('houseType')),
                          ),
                          _SpaceList(
                            title: '客厅',
                            subtitle: '请上传客厅图并写下描述',
                            controller: state.parlourController,
                            imgs: state.parlourImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('parlour')),
                          ),
                          _SpaceList(
                            title: '厨房',
                            subtitle: '请上传厨房图并写下描述',
                            controller: state.kitchenController,
                            imgs: state.kitchenImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('kitchen')),
                          ),
                          _SpaceList(
                            title: '主卧',
                            subtitle: '请上传主卧图并写下描述',
                            controller: state.masterBedroomController,
                            imgs: state.masterBedroomImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs(
                                    'masterBedroom')),
                          ),
                          _SpaceList(
                            title: '次卧',
                            subtitle: '请上传次卧图并写下描述',
                            controller: state.secondBedroomController,
                            imgs: state.secondBedroomImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs(
                                    'secondBedroom')),
                          ),
                          _SpaceList(
                            title: '卫生间',
                            subtitle: '请上传卫生间图并写下描述',
                            controller: state.toiletController,
                            imgs: state.toiletImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('toilet')),
                          ),
                          _SpaceList(
                            title: '书房',
                            subtitle: '请上传书房图并写下描述',
                            controller: state.studyRoomController,
                            imgs: state.studyRoomImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('studyRoom')),
                          ),
                          _SpaceList(
                            title: '阳台',
                            subtitle: '请上传阳台图并写下描述',
                            controller: state.balconyController,
                            imgs: state.balconyImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('balcony')),
                          ),
                          _SpaceList(
                            title: '走廊',
                            subtitle: '请上传走廊图并写下描述',
                            controller: state.corridorController,
                            imgs: state.corridorImages,
                            onTap: () => dispatch(
                                DecorateActionCreator.selectImgs('corridor')),
                          ),
                        ])
                      ],
                    ),
                  ),
                ),
                Container(
                    height: Adapt.screenH(),
                    child: SingleChildScrollView(
                      // physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[300]))),
                            padding: EdgeInsets.fromLTRB(
                                Adapt.width(20),
                                Adapt.width(20),
                                Adapt.width(20),
                                Adapt.width(30)),
                            child: Row(
                              children: [
                                Icon(Icons.wb_incandescent_outlined),
                                SizedBox(
                                  width: Adapt.width(30),
                                ),
                                Text(
                                  '(以下项目非必填)',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                          _ListWidget(
                            title: '装修风格',
                            content: state.houseStyle,
                            type: 'notRequired',
                            onTap: () => {
                              showDialog(
                                context: viewService.context,
                                builder: (_) => _HouseTypeList(
                                  type: 'style',
                                  onTap: (d) => {
                                    dispatch(DecorateActionCreator.updateNeeds(
                                        d, 'style'))
                                  },
                                  selected: state.houseType,
                                ),
                              )
                            },
                          ),
                          _ListWidget(
                            title: '装修周期',
                            content: state.duration,
                            type: 'notRequired',
                            onTap: () => {
                              showDialog(
                                context: viewService.context,
                                builder: (_) => _MaisonetteList(
                                  type: 'duration',
                                  onTap: (d) => {
                                    dispatch(DecorateActionCreator.updateNeeds(
                                        d, 'duration'))
                                  },
                                  selected: state.maisonette,
                                ),
                              )
                            },
                          ),
                          _ListWidget(
                            title: '其他需求',
                            content: state.needsController?.text,
                            type: 'notRequired',
                            onTap: () => {
                              showDialog(
                                  context: viewService.context,
                                  builder: (_) => _TextFiledDialog(
                                        controller: state.needsController,
                                      ))
                            },
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ]),
  );
}

class _ListWidget extends StatelessWidget {
  final String title;
  final String content;
  final Function onTap;
  final String type;
  const _ListWidget({this.content, this.onTap, this.title, this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: Adapt.height(100),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Adapt.width(20),
            ),
            type == 'notRequired'
                ? Expanded(
                    flex: 1,
                    child: Container(),
                  )
                : Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.new_releases_rounded,
                      color: Colors.red,
                      size: Adapt.height(15),
                    ),
                  ),

            // SizedBox(
            //   width: Adapt.width(30),
            // ),
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: Adapt.sp(32), fontWeight: FontWeight.w600),
              ),
            ),

            // SizedBox(
            //   width: Adapt.width(350),
            // ),
            Expanded(
                flex: 6,
                child: InkWell(
                  onTap: onTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              content ?? '',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: Adapt.height(3)),
                        child: Icon(
                          Icons.chevron_right,
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
        ));
  }
}

class _HouseTypeList extends StatelessWidget {
  final Function(String) onTap;
  final String selected;
  final String type;
  const _HouseTypeList({this.onTap, this.selected, this.type});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? Colors.white
        : _theme.primaryColorDark;
    final List<String> data = [
      '一室一厅',
      '二室一厅',
      '三室一厅',
      '二室二厅',
      '三室二厅',
      '四室一厅',
      '四室二厅',
      '五室及以上'
    ];
    final List<String> styleList = [
      '现代简约风',
      '北欧风',
      '清新田园风',
      '后现代风',
      '美式风',
      '新中式风',
      '欧式古典风',
      '神秘地中海风',
      '东南亚风',
      '日式和风'
    ];
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      title: Text(type == 'style' ? '请选择装修风格' : '请选择户型',
          style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
          height: _size.height / 2,
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: type == 'style' ? styleList.length : data.length,
            itemBuilder: (_, index) {
              final _language =
                  type == 'style' ? styleList[index] : data[index];
              return _LangageListCell(
                onTap: (l) => onTap(l),
                selected: selected == _language,
                language: _language,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TextFiledDialog extends StatelessWidget {
  final Function(String) onTap;
  final TextEditingController controller;
  const _TextFiledDialog({this.onTap, this.controller});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? Colors.white
        : _theme.primaryColorDark;
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      title: Text('请写下您的其他装修需求', style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
            height: _size.height / 3,
            width: _size.width,
            padding: EdgeInsets.all(Adapt.width(30)),
            child: TextField(
              controller: controller,
              maxLines: 10,
              maxLength: 500,
              decoration: InputDecoration(
                  helperText: '至多输入500字',
                  hintText: '例如:功能需要、便于清洁、经济实用、材料环保、工期短等等',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  // labelText: '其他需求',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
            )),
      ],
    );
  }
}

class _MaisonetteList extends StatelessWidget {
  final Function(String) onTap;
  final String selected;
  final String type;
  const _MaisonetteList({this.onTap, this.selected, this.type});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? Colors.white
        : _theme.primaryColorDark;
    final List<String> data = [
      '复式',
      '非复式',
    ];
    final List<String> durationList = [
      '一个月',
      '两个月',
      '三个月',
      '四个月',
      '五个月',
      '六个月'
    ];
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      title: Text(type == 'duration' ? '请选择装修周期' : '请选择是否复式',
          style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
          height: _size.height / 2.5,
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: type == 'duration' ? durationList.length : data.length,
            itemBuilder: (_, index) {
              final _language =
                  type == 'duration' ? durationList[index] : data[index];
              return _LangageListCell(
                onTap: (l) => onTap(l),
                selected: selected == _language,
                language: _language,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LangageListCell extends StatelessWidget {
  final Function onTap;
  final String language;
  final bool selected;
  const _LangageListCell({this.onTap, this.language, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(language);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: selected
            ? BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5),
              )
            // border: Border.all(color: Colors.black))
            : null,
        child: Text(
          language,
          style: TextStyle(
              color: Colors.black,
              fontSize: Adapt.sp(32),
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
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
