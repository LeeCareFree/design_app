import 'package:bluespace/components/numberKeyboard.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/pages/personal_page/view.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

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
              0, Adapt.height(15), Adapt.height(20), Adapt.height(20)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.radius(50)),
              color: Colors.blueGrey),
          child: TextButton(
              onPressed: () => {},
              child: Text(
                '预览',
                style: TextStyle(color: Colors.white),
              )),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(
              0, Adapt.height(15), Adapt.height(20), Adapt.height(20)),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.radius(50)),
              color: Colors.blueGrey),
          child: TextButton(
              onPressed: () => {},
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
                    height: Adapt.screenH(),
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
                                        DecorateActionCreator.selectHouseType(
                                            d))
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
                              dispatch(
                                  DecorateActionCreator.selectHouseLocation())
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
                        ],
                      ),
                    )),
                viewService.buildComponent('houseDetail'),
                Center(child: Text('Content of Profile')),
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
  const _ListWidget({this.content, this.onTap, this.title});
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
            Expanded(
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
  const _HouseTypeList({this.onTap, this.selected});
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
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
      title: Text('请选择户型', style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
          height: _size.height / 2,
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (_, index) {
              final _language = data[index];
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
