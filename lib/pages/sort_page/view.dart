import 'dart:convert';

import 'package:bluespace/components/drapdown.dart';
import 'package:bluespace/components/searchBar.dart';
import 'package:bluespace/components/stickTabBarDelegate.dart';
import 'package:bluespace/config/filter_data.dart';
import 'package:bluespace/models/designer_list.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(SortState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
        backgroundColor: const Color(0xFFEDF6FD),
        appBar: AppBar(
          backgroundColor: _theme.bottomAppBarColor,
          brightness: Brightness.light,
          elevation: 3.0,
          title: SearchBar(
              // onTap: () => dispatch(HomeActionCreator.onSearchBarTapped()),
              ),
        ),
        body: DefaultDropdownMenuController(
            onSelected: ({int menuIndex, List data}) {
              dispatch(SortActionCreator.tapHead(menuIndex));
              // print(data);
              if (menuIndex == 0) {
                print(data);
                dispatch(SortActionCreator.conditionalSearch(
                    'designfee', data[0]['value']));
              }
              if (menuIndex == 1) {
                var arrList = [];
                print(data);
                data.map((e) => {print(111)});
                dispatch(SortActionCreator.conditionalSearch(
                    'stylearr', data[0]['value']));
              }
              if (menuIndex == 2) {
                print(data);
                dispatch(SortActionCreator.conditionalSearch(
                    'service', data[0]['value']));
              }
            },
            child: Stack(children: [
              Column(
                children: [
                  _DropdownHeader(),
                  Expanded(
                      child: SmartRefresher(
                          enablePullDown: true,
                          controller: state.refreshController,
                          onRefresh: () => {
                                dispatch(SortActionCreator.getDesignerList()),
                              },
                          child: _DesignerListWidget(
                            designerList: state.designerList,
                          ))),
                ],
              ),
              _DropDownMenu(),
            ])));
  });
}

class _DropdownHeader extends StatelessWidget {
  final Function onTap;
  const _DropdownHeader({this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: DropdownHeader(
          isSideline: false,
          selectColor: Colors.black,
          onTap: onTap,
          titles: ['价格', '服务', '风格', '排序'],
          selectIsChangingColor: true,
          specialModules: [1],

          ///特殊模块,选中数据只亮起,不需要更改头部title,下标为1
        ));
  }
}

class _DropDownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: Adapt.height(80)),
        child: DropdownMenu(menus: [
          DropdownMenuBuilder(
              builder: (BuildContext context) {
                return DropdownListMenu(
                  selectedIndex: FilterData.amount[0],
                  isOperatingButton: true,
                  isCustomInput: true,
                  customInput: CustomInputClass(
                    startHintText: '最低(/㎡)',
                    endHintText: '最高(㎡)',
                  ),
                  keyWords: "key",
                  isMultiple: false,
                  data: FilterData.amount,
                  valueKey: 'value',
                  itemBuilder: buildCheckItem,
                );
              },
              screenHeight: MediaQuery.of(context).size.height,
              draughtHeight: Adapt.height(100) * FilterData.amount.length,
              bottomSpacingHeight: Adapt.height(200)),
          DropdownMenuBuilder(
            builder: (BuildContext context) {
              return DropdownListMenu(
                selectedIndex: FilterData.services[0],
                isOperatingButton: true,
                isMultiple: true,
                keyWords: "key",
                data: FilterData.services,
                itemBuilder: buildCheckItem,
              );
            },
            screenHeight: MediaQuery.of(context).size.height,
            draughtHeight: Adapt.height(110) * FilterData.services.length,
          ),
          DropdownMenuBuilder(
            builder: (BuildContext context) {
              return DropdownListMenu(
                selectedIndex: FilterData.styles[0],
                isOperatingButton: true,
                isMultiple: true,
                keyWords: "key",
                data: FilterData.styles,
                itemBuilder: buildCheckItem,
              );
            },
            screenHeight: MediaQuery.of(context).size.height,
            draughtHeight: Adapt.height(100) * FilterData.styles.length / 2,
          ),
          DropdownMenuBuilder(
              builder: (BuildContext context) {
                return DropdownListMenu(
                  selectedIndex: FilterData.sort[0],
                  isOperatingButton: true,
                  keyWords: "key",
                  isMultiple: true,
                  data: FilterData.sort,
                  itemBuilder: buildCheckItem,
                );
              },
              screenHeight: MediaQuery.of(context).size.height,
              draughtHeight: 60 * 6.66,
              bottomSpacingHeight: 168.0 + 50.0),
        ]));
  }
}

class _DesignerListWidget extends StatelessWidget {
  final DesignerList designerList;
  const _DesignerListWidget({this.designerList});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) => Container(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Adapt.radius(40))),
                padding: EdgeInsets.symmetric(vertical: Adapt.height(20)),
                margin: EdgeInsets.fromLTRB(Adapt.width(30), Adapt.height(10),
                    Adapt.width(30), Adapt.height(10)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Adapt.width(30),
                    ),
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        designerList?.result[index]?.avatar ?? '',
                      ),
                    ),
                    SizedBox(
                      width: Adapt.width(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          designerList?.result[index]?.nickname ?? '',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.sp(36)),
                        ),
                        SizedBox(
                          height: Adapt.height(10),
                        ),
                        Text(
                          '设计费：${designerList?.result[index]?.detailInfo?.designfee.toString()}元/㎡',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: Adapt.height(15),
                        ),
                        Container(
                          height: Adapt.height(40),
                          child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: designerList
                                ?.result[index]?.detailInfo?.stylearr?.length,
                            scrollDirection: Axis.horizontal,
                            // reverse: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: Adapt.width(10),
                              crossAxisSpacing: Adapt.height(10),
                            ),
                            itemBuilder: (context, index) => Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.green[200],
                                  borderRadius:
                                      BorderRadius.circular(Adapt.radius(20)),
                                ),
                                child: Text(
                                  designerList?.result[index]?.detailInfo
                                          ?.stylearr[index] ??
                                      '',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: Adapt.sp(20)),
                                )),
                          ),
                        ),
                        SizedBox(
                          height: Adapt.height(15),
                        ),
                        Container(
                          width: Adapt.screenW() - Adapt.width(200),
                          height: Adapt.height(150),
                          child: ListView(
                            reverse: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: designerList?.result[index]?.prodImgList
                                ?.map((e) => GestureDetector(
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(
                                                        Adapt.radius(20))),
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.network(
                                          designerList?.result[index]
                                                  ?.prodImgList[0] ??
                                              '',
                                        ))))
                                .toList(),
                          ),
                        )
                      ],
                    )
                  ],
                ))),
        itemCount: designerList?.result?.length);
  }
}
