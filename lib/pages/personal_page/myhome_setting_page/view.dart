import 'package:bluespace/components/numberKeyboard.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:bluespace/pages/decorate_page/view.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'action.dart';
import 'state.dart';

Widget buildView(
    MyhomeSettingState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return WillPopScope(
      onWillPop: () {
        dispatch(MyhomeSettingActionCreator.back(state.myhomeInfo));

        ///true：表示执行页面返回    false:表示不执行返回页面操作，这里因为要传值，所以接管返回操作
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: _theme.backgroundColor,
          appBar: AppBar(
            iconTheme: _theme.iconTheme,
            elevation: 3.0,
            backgroundColor: _theme.bottomAppBarColor,
            brightness: _theme.brightness,
            title: Text(
              '编辑我的家',
              style: TextStyle(color: Colors.black, fontSize: Adapt.sp(32)),
            ),
            centerTitle: true,
          ),
          body: Container(
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
                        dataList: [
                          '一室一厅',
                          '二室一厅',
                          '三室一厅',
                          '二室二厅',
                          '三室二厅',
                          '四室一厅',
                          '四室二厅',
                          '五室及以上'
                        ],
                        type: "户型",
                        onTap: (d) => {
                          dispatch(
                              MyhomeSettingActionCreator.selectHouseType(d))
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
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              titleTextStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              title: Text('请输入房屋面积',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              children: [
                                NumberKeyboardActionSheet(
                                  controller: state.numberController,
                                  callback: (text) => dispatch(
                                      MyhomeSettingActionCreator
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
                    dispatch(MyhomeSettingActionCreator.selectHouseLocation())
                  },
                ),
                _ListWidget(
                  title: '装修进度',
                  content: state.progress,
                  onTap: () => {
                    showDialog(
                      context: viewService.context,
                      builder: (_) => _HouseTypeList(
                        type: "装修进度",
                        dataList: [
                          '准备装修',
                          '正在装修',
                          '不需要装修',
                        ],
                        onTap: (d) => {
                          dispatch(
                              MyhomeSettingActionCreator.setHouseProgress(d))
                        },
                        selected: state.houseType,
                      ),
                    )
                  },
                ),
                _ListWidget(
                  title: '预算',
                  type: "notRequired",
                  content: state.houseBudget,
                  onTap: () => {
                    showDialog(
                        context: viewService.context,
                        builder: (_) => SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0.0,
                              backgroundColor: Colors.white,
                              titleTextStyle:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              title: Text('请输入装修预算',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              children: [
                                NumberKeyboardActionSheet(
                                  controller: state.numberController,
                                  callback: (text) => dispatch(
                                      MyhomeSettingActionCreator
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
                  title: '常住人口',
                  type: "notRequired",
                  content: state.personalNum,
                  onTap: () => {
                    showDialog(
                        context: viewService.context,
                        barrierDismissible: true,
                        builder: (ctx) {
                          return SimpleDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            titleTextStyle:
                                TextStyle(color: Colors.black, fontSize: 18),
                            title: Text('请选择常住人口'),
                            contentPadding: EdgeInsets.zero,
                            children: [
                              NumChoose1(
                                callback: (_) => dispatch(
                                    MyhomeSettingActionCreator.setPersoanlNum(
                                        _)),
                              )
                            ],
                          );
                        })
                  },
                ),
                _ListWidget(
                  title: '开始装修时间',
                  type: "notRequired",
                  content: state.beginTime,
                  onTap: () => {
                    DatePicker.showDatePicker(viewService.context,
                        // 是否展示顶部操作按钮
                        showTitleActions: true,
                        // 最小时间
                        minTime: DateTime(2018, 3, 5),
                        // 最大时间
                        maxTime: DateTime(2099, 6, 7),
                        // change事件
                        onChanged: (date) {},
                        // 确定事件
                        onConfirm: (date) {
                      dispatch(MyhomeSettingActionCreator.setBeginTime(
                          date.toString().substring(0, 10)));
                    },
                        // 当前时间
                        currentTime: DateTime.now(),
                        // 语言
                        locale: LocaleType.zh)
                  },
                ),
                _ListWidget(
                  title: '计划入住时间',
                  type: "notRequired",
                  content: state.intoTime,
                  onTap: () => {
                    DatePicker.showDatePicker(viewService.context,
                        // 是否展示顶部操作按钮
                        showTitleActions: true,
                        // 最小时间
                        minTime: DateTime(2018, 3, 5),
                        // 最大时间
                        maxTime: DateTime(2099, 6, 7),
                        // change事件
                        onChanged: (date) {},
                        // 确定事件
                        onConfirm: (date) {
                      dispatch(MyhomeSettingActionCreator.setIntoTime(
                          date.toString().substring(0, 10)));
                    },
                        // 当前时间
                        currentTime: DateTime.now(),
                        // 语言
                        locale: LocaleType.zh)
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(Adapt.radius(30))),
                  margin: EdgeInsets.all(Adapt.height(60)),
                  child: TextButton(
                    onPressed: () =>
                        dispatch(MyhomeSettingActionCreator.submit()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(children: [
                          Text(
                            '确认提交',
                            style: TextStyle(color: Colors.black54),
                          )
                        ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ))));
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
  final List<String> dataList;
  final Function(String) onTap;
  final String selected;
  final String type;
  const _HouseTypeList({this.dataList, this.onTap, this.selected, this.type});
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
      title: Text('请选择$type', style: TextStyle(fontWeight: FontWeight.w600)),
      children: [
        Container(
          height: dataList.length * Adapt.height(100),
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: dataList.length,
            itemBuilder: (_, index) {
              final _language = dataList[index];
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

class NumChoose extends StatelessWidget {
  NumChoose({this.changeBookIdCallBack});
  final ValueChanged<int> changeBookIdCallBack;
  final PageController pagecontroller =
      new PageController(viewportFraction: 0.3, initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        height: Adapt.height(200),
        width: Adapt.width(100),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: Adapt.height(80),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(width: Adapt.width(1)),
                        bottom: BorderSide(width: Adapt.width(1)))),
              ),
            ),
            PageView.builder(
              itemCount: 10,
              controller: pagecontroller,
              scrollDirection: Axis.vertical,
              pageSnapping: true,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (ctx, index) {
                return Center(
                    child: Text(
                  '$index',
                  style: TextStyle(fontSize: Adapt.sp(36)),
                ));
              },
              onPageChanged: (int index) {
                changeBookIdCallBack(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NumChoose1 extends StatefulWidget {
  int index1;
  int index2;
  int index3;
  Function callback;
  NumChoose1({this.index1, this.index2, this.index3, this.callback});
  @override
  _NumChoose1State createState() => _NumChoose1State();
}

class _NumChoose1State extends State<NumChoose1> {
  void initState() {
    super.initState();
    widget.index1 = 0;
    widget.index2 = 0;
    widget.index3 = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NumChoose(changeBookIdCallBack: (pageNum2) {
              setState(() {
                widget.index1 = pageNum2;
              });
            }),
            Text('成人'),
            NumChoose(changeBookIdCallBack: (pageNum2) {
              setState(() {
                widget.index2 = pageNum2;
              });
            }),
            Text('老人'),
            NumChoose(changeBookIdCallBack: (pageNum2) {
              setState(() {
                widget.index3 = pageNum2;
              });
            }),
            Text('儿童'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
                child: Text('确认'),
                onPressed: () {
                  Navigator.of(context).pop();
                  widget.callback((widget.index1).toString() +
                      " 成人 " +
                      (widget.index2).toString() +
                      ' 老人 ' +
                      (widget.index3).toString() +
                      " 儿童 ");
                })
          ],
        )
      ],
    );
  }
}
