import 'dart:ui';

import 'package:bluespace/utils/adapt.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum DropdownEvent {
  // 关闭
  HIDE,

  // 打开
  ACTIVE,

  // 传输数据
  SELECT
}

class DropdownMenuController extends ChangeNotifier {
  ///下拉状态
  DropdownEvent event;

  ///当前操作下标
  int menuIndex;

  /// 选中内容
  dynamic data;

  void hide() {
    event = DropdownEvent.HIDE;
    notifyListeners();
  }

  void show(int index) {
    event = DropdownEvent.ACTIVE;
    menuIndex = index;
    notifyListeners();
  }

  ///自定义赋值
  void select(dynamic _data, [int index]) {
    event = DropdownEvent.SELECT;
    this.data = _data;
    if (index != null) {
      this.menuIndex = index;
    }
    notifyListeners();
  }

  ///单纯的赋值,不做操作,适用于非弹出页面,复杂模块赋值
  void assignment(dynamic _data, [int index]) {
    this.data = _data;
    if (index != null) {
      this.menuIndex = index;
    }
  }
}

typedef DropdownMenuOnSelected({int menuIndex, List data});

class DefaultDropdownMenuController extends StatefulWidget {
  const DefaultDropdownMenuController({
    Key key,
    @required this.child,
    this.onSelected,
  }) : super(key: key);

  final Widget child;

  final DropdownMenuOnSelected onSelected;

  static DropdownMenuController of(BuildContext context) {
    final _DropdownMenuControllerScope scope = context
        ?.dependOnInheritedWidgetOfExactType<_DropdownMenuControllerScope>();
    return scope?.controller;
  }

  @override
  _DefaultDropdownMenuControllerState createState() =>
      new _DefaultDropdownMenuControllerState();
}

class _DefaultDropdownMenuControllerState
    extends State<DefaultDropdownMenuController>
    with SingleTickerProviderStateMixin {
  DropdownMenuController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new DropdownMenuController();
    _controller.addListener(_onController);
  }

  void _onController() {
    switch (_controller.event) {
      case DropdownEvent.SELECT:
        {
          //通知widget
          if (widget.onSelected == null) return;
          widget.onSelected(
            data: _controller.data,
            menuIndex: _controller.menuIndex,
          );
        }
        break;
      case DropdownEvent.ACTIVE:
        break;
      case DropdownEvent.HIDE:
        break;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onController);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _DropdownMenuControllerScope(
      controller: _controller,
      enabled: TickerMode.of(context),
      child: widget.child,
    );
  }
}

class _DropdownMenuControllerScope extends InheritedWidget {
  const _DropdownMenuControllerScope(
      {Key key, this.controller, this.enabled, Widget child})
      : super(key: key, child: child);

  final DropdownMenuController controller;
  final bool enabled;

  @override
  bool updateShouldNotify(_DropdownMenuControllerScope old) {
    return enabled != old.enabled || controller != old.controller;
  }
}

abstract class DropdownWidget extends StatefulWidget {
  final DropdownMenuController controller;

  const DropdownWidget({Key key, this.controller}) : super(key: key);

  @override
  DropdownState<DropdownWidget> createState();
}

abstract class DropdownState<T extends DropdownWidget> extends State<T> {
  DropdownMenuController controller;

  @override
  void dispose() {
    if (controller != null) {
      controller.removeListener(_onController);
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (controller == null) {
      if (widget.controller == null) {
        controller = DefaultDropdownMenuController.of(context);
      } else {
        controller = widget.controller;
      }

      if (controller != null) {
        controller.addListener(_onController);
      }
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    if (widget.controller != null) {
      if (controller != null) {
        controller.removeListener(_onController);
      }
      controller = widget.controller;
      controller.addListener(_onController);
    }

    super.didUpdateWidget(oldWidget);
  }

  void _onController() {
    onEvent(controller.event);
  }

  void onEvent(DropdownEvent event);
}

class DropdownMenuBuilder {
  final WidgetBuilder builder;

  /* *
   * 计算高度
   * TODO : 例子60 * 6.66;[6行][每行6.66高]
   */
  final double draughtHeight;

  ///手机高度
  final double screenHeight;
  /* *
   * 距离底部间距
   */
  final double bottomSpacingHeight;

  ///计算出的高度
  final double height;

  /* *
   *  TODO : height =  (screenHeight != null && screenHeight > 0.0) ? ((screenHeight - bottomSpacingHeight) > draughtHeight) ? draughtHeight : (screenHeight - bottomSpacingHeight) : draughtHeight;
   *  TODO : 计算高度
   *  TODO : 如果给了屏幕高度screenHeight以及距离底部高度则进行计算
   *  TODO : 屏幕高度减去距离底部高度,对比计算高度,取出最小的做高度使用
   */
  //if height == null , use [DropdownMenu.maxMenuHeight]
  const DropdownMenuBuilder(
      {@required this.builder,
      @required this.draughtHeight,
      this.screenHeight,
      this.bottomSpacingHeight = 0.0})
      : height =
            (screenHeight != null && screenHeight != 0.0 && screenHeight > 0.0)
                ? ((screenHeight - bottomSpacingHeight) > draughtHeight)
                    ? draughtHeight
                    : (screenHeight - bottomSpacingHeight)
                : draughtHeight,
        assert(builder != null);
}

typedef void DropdownMenuHeadTapCallback(int index);

///头部样式
typedef String GetItemLabel(dynamic data, [String valueKey]);

///头部图标样式
typedef Widget GetCustomizeImage(bool selected, bool subjectiveSelected);

///文本显示title提取
String defaultGetItemLabel(dynamic data, [String valueKey]) {
  if (data is String) return data;
  if (data is Map) {
    ///自定义显示文本字段
    if (valueKey != null) {
      if (data.containsKey(valueKey)) {
        if (data[valueKey] != null) {
          return data[valueKey];
        }
      }
    }
    if (data.containsKey('title')) {
      if (data["title"] != null) {
        return data["title"];
      }
    }
  }
  if (data is List) {
    ///多选情况赋值第一个
    if (data.length >= 1) {
      try {
        String _title = data[0]["title"];
        if (_title.isNotEmpty) {
          return _title;
        }
      } catch (err) {
        return '';
      }
    }
  }
  return '';
}

class DropdownHeader extends DropdownWidget {
  final List<dynamic> titles;
  final bool selectIsChangingColor;

  ///选中查询内容是否显示选中颜色
  final int activeIndex;
  final Color selectColor;
  final Color unselectedColor;
  final bool isSideline;

  ///是否有边线
  final DropdownMenuHeadTapCallback onTap;
  final String dropDownImage;

  ///未选中图标
  final String dropDownSelectImage;

  ///选中图标
  final List<int> specialModules;

  ///只显示不回填值
  final GetCustomizeImage imageWidget;

  ///自定义头部图标

  /// 筛选头部高度
  final double height;

  /// 头部显示内容
  final GetItemLabel getItemLabel;

  const DropdownHeader(
      {@required this.titles,
      this.activeIndex,
      DropdownMenuController controller,
      this.onTap,
      this.selectIsChangingColor = false,
      this.selectColor,
      this.unselectedColor,
      this.specialModules = const [],
      Key key,
      this.height: 46.0,
      this.isSideline = true,
      this.dropDownSelectImage,
      this.dropDownImage,
      this.imageWidget,
      GetItemLabel getItemLabel})
      : getItemLabel = getItemLabel ?? defaultGetItemLabel,
        assert(titles != null && titles.length > 0),
        super(key: key, controller: controller);

  @override
  DropdownState<DropdownWidget> createState() {
    return new _DropdownHeaderState();
  }
}

class _DropdownHeaderState extends DropdownState<DropdownHeader> {
  bool contentSelected = false;
  Widget buildItem(BuildContext context, dynamic title, bool selected,
      int index, dynamic _title) {
    double _screenWidth = MediaQuery.of(context).size.width - 20;
    final Color primaryColor =
        widget.selectColor ?? Theme.of(context).primaryColor;
    final Color unselectedColor =
        widget.unselectedColor ?? Theme.of(context).unselectedWidgetColor;
    final GetItemLabel getItemLabel = widget.getItemLabel;
    bool _selected = false;
    dynamic _showTitle = title;

    ///选中后是否亮起
    if (widget.selectIsChangingColor) {
      if (!(_title == title)) {
        _selected = true;

        ///处理特殊显示问题,有些样例只需要显示颜色不需要更改头部title
        if (widget.specialModules.length > 0) {
          if (widget.specialModules.contains(index)) {
            _showTitle = _title;
          }
        }
      }
    }
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: DecoratedBox(
              decoration: new BoxDecoration(
                  border: widget.isSideline
                      ? Border(left: Divider.createBorderSide(context))
                      : null),
              child: new Container(
                margin: const EdgeInsets.only(left: 1.0, right: 1.0),
                width: (_screenWidth / widget.titles.length) - 20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Container(
                            child: Text(
                              getItemLabel(_showTitle),
                              style: TextStyle(
                                  color: _selected
                                      ? primaryColor
                                      : selected
                                          ? primaryColor
                                          : unselectedColor,
                                  fontSize: 15.0),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )),
                          Container(
                            width: 0.0,
                          )
                        ],
                      ),
                    ),
                    _imageAsset(
                        selected, _selected, primaryColor, unselectedColor)
                  ],
                ),
              ))),
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap(index);
          return;
        }
        if (controller != null) {
          if (_activeIndex == index) {
            controller.hide();
            setState(() {
              _activeIndex = null;
            });
          } else {
            if (_activeIndex != null) {
              controller.hide();
              ////TODO : 延时处理show时蒙层刚关闭没反应过来
              Future.delayed(const Duration(milliseconds: 250), () {
                controller.show(index);
              });
              return;
            }
            controller.show(index);
          }
        }
        //widget.onTap(index);
      },
    );
  }

  ///处理图标
  Widget _imageAsset(bool selected, bool _selected, Color primaryColor,
      Color unselectedColor) {
    if (widget.imageWidget != null) {
      return widget.imageWidget(selected, _selected);
    }
    if (widget.dropDownImage == null || widget.dropDownSelectImage == null) {
      return Icon(
        selected ? Icons.arrow_drop_up : Icons.arrow_drop_down,
        color: _selected
            ? primaryColor
            : selected
                ? primaryColor
                : unselectedColor,
      );
    }
    return Image.asset(
      selected ? widget.dropDownSelectImage : widget.dropDownImage,
      width: 18.0,
      height: 18.0,
      color: _selected
          ? primaryColor
          : selected
              ? primaryColor
              : unselectedColor,
    );
  }

  int _activeIndex;

  ///选中菜单index
  List<dynamic> _titles;

  ///头部重新赋值
  List<dynamic> _titlesCopy;

  /// 保留原始头部值

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    final int activeIndex = _activeIndex;
    final List<dynamic> titles = _titles;
    final double height = widget.height;
    for (int i = 0, c = widget.titles.length; i < c; ++i) {
      list.add(
          buildItem(context, titles[i], i == activeIndex, i, _titlesCopy[i]));
    }

    list = list.map((Widget widget) {
      return new Expanded(
        child: widget,
      );
    }).toList();

    final Decoration decoration = new BoxDecoration(
      border: new Border(
        bottom: Divider.createBorderSide(context),
      ),
    );

    return new DecoratedBox(
      decoration: decoration,
      child: new SizedBox(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: list,
          ),
          height: height),
    );
  }

  @override
  void initState() {
    _titles = widget.titles;
    _titlesCopy = []..addAll(widget.titles);
    super.initState();
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
        {
          setState(() {
            _activeIndex = null;
            String label = widget.getItemLabel(controller.data);
            try {
              _titles[controller.menuIndex] =
                  label == "" ? _titles[controller.menuIndex] : label;
            } catch (err) {}
          });
        }
        break;
      case DropdownEvent.HIDE:
        {
          print('选中内容HIDE = ${controller.data}');
          if (_activeIndex == null) return;
          setState(() {
            _activeIndex = null;
          });
        }
        break;
      case DropdownEvent.ACTIVE:
        {
          if (_activeIndex == controller.menuIndex) return;
          setState(() {
            _activeIndex = controller.menuIndex;
          });
        }
        break;
    }
  }
}

typedef Widget MenuItemBuilder<T>(
    BuildContext context, T data, bool selected, String valueKey);

///自定义按钮,重置按钮,确定按钮,选中数据,自定义处置通知按钮
typedef Widget MenuButtonBuilder(BuildContext context, Object data,
    {VoidCallback resetOnTap, VoidCallback fixOnTap, VoidCallback noticeOnTap});

class CustomInputClass {
  final String startInput;

  ///开始输入内容
  final String endInput;

  ///结束输入内容
  final String startHintText;

  ///开始展示提示
  final String endHintText;

  ///结束框展示提示
  final TextInputType keyboardType;

  ///输入格式
  const CustomInputClass(
      {this.startInput = 'startInput',
      this.endInput = 'endInput',
      this.startHintText = '',
      this.endHintText = '',
      this.keyboardType});
}

class DropdownListMenu<T> extends DropdownWidget {
  final List<T> data;
  final dynamic keyWords;

  ///作为判断依据的key
  final String valueKey;

  ///显示内容的key
  final bool isOperatingButton;

  ///是否包含按钮
  final dynamic selectedIndex;

  ///初始化选中数据
  final MenuItemBuilder itemBuilder;
  final MenuButtonBuilder buttonBuilder;

  ///自定义按钮
  final bool isCustomInput;

  ///是否自定义输入
  final bool isMultiple;

  ///是否多选
  final CustomInputClass customInput;

  ///定义输入文本格式字段key
  const DropdownListMenu({
    @required this.keyWords,
    @required this.data,
    this.isOperatingButton = true,
    this.isCustomInput = false,
    this.buttonBuilder,
    this.valueKey,
    this.customInput,
    this.isMultiple = false,
    this.selectedIndex,
    this.itemBuilder,
  });

  @override
  DropdownState<DropdownWidget> createState() {
    return new _MenuListState<T>();
  }
}

class _MenuListState<T> extends DropdownState<DropdownListMenu<T>> {
  dynamic _selectedIndex;
  bool _isMultiple = false;
  bool _isCustomInput = false;
  String minPrince = "";
  String maxPrince = "";
  Map princes = {};
  List<dynamic> _superclassIndex = [];

  ///传出给父类最最终值
  List<dynamic> _subclassIndex = [];

  ///子类操作值
  bool isRegular = false;

  @override
  void initState() {
    _isCustomInput = widget.isCustomInput;
    _subclassIndex = [widget.selectedIndex];
    _selectedIndex = widget.selectedIndex;
    _isMultiple = widget.isMultiple;
    // princes[widget.customInput?.startInput] = null;
    // princes[widget.customInput?.endInput] = null;
    super.initState();
  }

  bool _contains(dynamic element, List<dynamic> list) {
    ///判断是否相同
    for (var i = 0; i < list.length; i++) {
      if (list[i][widget.keyWords] == element[widget.keyWords]) {
        return true;
      }
    }
    return false;
  }

  Widget buildItem(BuildContext context, int index) {
    final List<T> list = widget.data;
    final T data = list[index];
    return new GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: const Color(0XFFFFFFFF),
        child: widget.itemBuilder(
            context, data, _contains(data, _subclassIndex), widget.valueKey),
      ),
      onTap: () {
        isRegular = true;
        FocusScope.of(context).requestFocus(FocusNode());
        _dealingMultiple(data);
      },
    );
  }

  void _dealingMultiple(dynamic data) {
    setState(() {
      if (!_contains(data, _subclassIndex)) {
        ///处理多选与单选问题
        if (!_isMultiple ||
            data[widget.keyWords] == _selectedIndex[widget.keyWords]) {
          _subclassIndex.clear();
          if (!_isMultiple) {
            _superclassIndex.clear();
            _superclassIndex.add(data);
            _subclassIndex.add(data);
            assert(controller != null);
            controller.select(_subclassIndex);
          }
        }
        if (_isMultiple &&
            data[widget.keyWords] != _selectedIndex[widget.keyWords]) {
          if (_contains(_selectedIndex, _subclassIndex)) {
            _subclassIndex.remove(_selectedIndex);
            _subclassIndex.clear();
          }
        }
        _subclassIndex.add(data);
      } else {
        if (_isMultiple) {
          _subclassIndex.remove(data);
        }
      }
      minPrince = "";
      maxPrince = "";
      if (_subclassIndex.length == 0) _subclassIndex.add(_selectedIndex);
    });
    if (widget.isMultiple && !widget.isOperatingButton) {
      _superclassIndex = []..addAll(_subclassIndex);
      assert(controller != null);
      controller.select(_superclassIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0XFFFFFFFF),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: _isCustomInput
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
//                           Expanded(
//                               child: Container(
//                             margin:
//                                 const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   child: TextField(
//                                     inputFormatters: [
//                                       // ignore: deprecated_member_use
//                                       WhitelistingTextInputFormatter.digitsOnly
//                                     ],
//                                     keyboardType: widget
//                                                 .customInput?.keyboardType ==
//                                             TextInputType.number
//                                         ? const TextInputType.numberWithOptions(
//                                             decimal: true)
//                                         : widget.customInput?.keyboardType ??
//                                             TextInputType.text,
//                                     autofocus: false,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintStyle: const TextStyle(
//                                           color: Color(0XFFC0C4CC),
//                                           fontSize: 18.0),
//                                       hintText:
//                                           "${widget.customInput?.startHintText ?? ''}",
//                                     ),
//                                     //使用controller保存输入框的值
//                                     controller: TextEditingController.fromValue(
//                                         TextEditingValue(
//                                             text: minPrince.toString(),
//                                             selection:
//                                                 new TextSelection.fromPosition(
//                                                     TextPosition(
//                                                         affinity: TextAffinity
//                                                             .downstream,
//                                                         offset: minPrince
//                                                             .toString()
//                                                             .length)))),

//                                     onChanged: (text) {
//                                       setState(() {
//                                         minPrince = text;
// //                                      princes['minPrince'] = minPrince;
//                                         princes[
//                                             widget.customInput?.startInput ??
//                                                 'value1'] = minPrince;
//                                         if (minPrince == '' &&
//                                             maxPrince == '') {
//                                           _subclassIndex.add(_selectedIndex);
//                                         } else {
//                                           _subclassIndex.clear();
//                                           _subclassIndex.remove(_selectedIndex);
//                                         }
//                                       });
//                                     },
//                                     onSubmitted: (text) {
// //                                    setState(() {
// //                                      minPrince = text;
// //
// ////                                      princes['minPrince'] = minPrince;
// //                                      _subclassIndex.remove(_selectedIndex);
// //                                    });
//                                     },
//                                   ),
//                                 ),
//                                 const Divider(
//                                   height: .5,
//                                   color: Color(0XFF909399),
//                                 )
//                               ],
//                             ),
//                           )),
                          // Container(
                          //   margin:
                          //       const EdgeInsets.symmetric(horizontal: 11.0),
                          //   child: const Text(
                          //     "至",
                          //     style: TextStyle(
                          //         color: Color(0XFF606266), fontSize: 15.0),
                          //   ),
                          // ),
//                           Expanded(
//                               child: Container(
//                             margin:
//                                 const EdgeInsets.symmetric(horizontal: 12.0),
//                             child: Column(
//                               children: <Widget>[
//                                 Container(
//                                   child: TextField(
//                                     inputFormatters: [
//                                       // ignore: deprecated_member_use
//                                       WhitelistingTextInputFormatter.digitsOnly
//                                     ],
//                                     keyboardType: widget
//                                                 .customInput?.keyboardType ==
//                                             TextInputType.number
//                                         ? const TextInputType.numberWithOptions(
//                                             decimal: true)
//                                         : widget.customInput?.keyboardType ??
//                                             TextInputType.text,
//                                     autofocus: false,
//                                     textAlign: TextAlign.center,
//                                     decoration: InputDecoration(
//                                         border: InputBorder.none,
//                                         hintText:
//                                             "${widget.customInput?.endHintText ?? ''}",
//                                         hintStyle: const TextStyle(
//                                             color: Color(0XFFC0C4CC),
//                                             fontSize: 18.0)),
//                                     //使用controller保存输入框的值
//                                     controller: TextEditingController.fromValue(
//                                         TextEditingValue(
//                                             text: maxPrince.toString(),
//                                             selection:
//                                                 new TextSelection.fromPosition(
//                                                     TextPosition(
//                                                         affinity: TextAffinity
//                                                             .downstream,
//                                                         offset: maxPrince
//                                                             .toString()
//                                                             .length)))),
//                                     onChanged: (text) {
//                                       setState(() {
//                                         maxPrince = text;
//                                         princes[widget.customInput?.endInput ??
//                                             'value2'] = maxPrince;
//                                         if (minPrince == '' &&
//                                             maxPrince == '') {
//                                           print(
//                                               "${minPrince == ''}||minPrince$minPrince,maxPrince$maxPrince ===${maxPrince == ''}");
//                                           _subclassIndex.add(_selectedIndex);
//                                         } else {
//                                           _subclassIndex.clear();
//                                           _subclassIndex.remove(_selectedIndex);
//                                         }
//                                       });
//                                     },
//                                     onSubmitted: (text) {
// //                                    setState(() {
// //                                      maxPrince = text;
// //                                      princes[widget.customInput.endInput??'value2'] = maxPrince;
// //                                      _subclassIndex.remove(_selectedIndex);
// //                                    });
//                                     },
//                                   ),
//                                 ),
//                                 const Divider(
//                                   height: .5,
//                                   color: Color(0XFF909399),
//                                 )
//                               ],
//                             ),
//                           )),
                        ],
                      )
                    : Container(),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemExtent: Adapt.height(80),
                  itemBuilder: buildItem,
                  itemCount: widget.data.length,
                ),
              ),
              _button(context)
            ],
          ),
        ));
  }

  Widget _button(BuildContext context) {
    if (widget.isOperatingButton) {
      if (widget.buttonBuilder == null) {
        return FilterButton(
          resetOnTap: () {
            _getResetOnTap();
          },
          fixOnTap: () {
            _getFixOnTap();
          },
        );
      }
      Map _item = {
        // widget.customInput?.startInput: minPrince,
        // widget.customInput?.endInput: maxPrince
      };
      List _list = []..addAll(_subclassIndex);
      // _list.add(_item);
      return widget.buttonBuilder(context, _list, fixOnTap: () {
        _getFixOnTap();
      }, resetOnTap: () {
        _getResetOnTap();
      }, noticeOnTap: () {
        assert(controller != null);
        controller.hide();
      });
    }
    return const SizedBox(
      height: 0.0,
    );
  }

  void _getFixOnTap() {
    FocusScope.of(context).requestFocus(FocusNode());
    isRegular = false;
    setState(() {
      ///赋值深拷贝，防止清除_subclassIndex时影响_superclassIndex，两种方式
//                         _superclassIndex = json.decode(json.encode(_subclassIndex));///此方式影响性能
      princes[widget.customInput?.startInput] = minPrince;
      princes[widget.customInput?.endInput] = maxPrince;
      _superclassIndex = []..addAll(_subclassIndex);
      // _superclassIndex.add(princes);
    });
    assert(controller != null);
    controller.select(_superclassIndex);
  }

  void _getResetOnTap() {
    isRegular = true;
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _subclassIndex.clear();
      _subclassIndex.add(_selectedIndex);
      maxPrince = "";
      minPrince = "";
    });
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        setState(() {
          if (_subclassIndex != _superclassIndex) {
            minPrince = princes[widget.customInput?.startInput];
            maxPrince = princes[widget.customInput?.endInput];
            if (_superclassIndex.length == 0)
              _superclassIndex.add(_selectedIndex);
            _subclassIndex = []..addAll(_superclassIndex);
          }
//          if(isRegular){
//            if(_subclassIndex != _superclassIndex){
//              if(_superclassIndex.length == 0)_superclassIndex.add(_selectedIndex);
//              _subclassIndex = []..addAll(_superclassIndex);
//            }
//          }
        });
        {}
        break;
      case DropdownEvent.ACTIVE:
        {}
        break;
    }
  }
}

enum DropdownMenuShowHideSwitchStyle {
  /// the showing menu will direct hide without animation
  directHideAnimationShow,

  /// the showing menu will direct hide without animation, and another menu shows without animation
  directHideDirectShow,

  /// the showing menu will hide with animation,and the same time another menu shows with animation
  animationHideAnimationShow,

  /// the showing menu will hide with animation,until the animation complete, another menu shows with animation
  animationShowUntilAnimationHideComplete,
}

class DropdownMenu extends DropdownWidget {
  /// menus whant to show
  final List<DropdownMenuBuilder> menus;

  /* *
   * 收起高度
   * TODO : 当下拉收起时出现一丢丢没有收起,可添加收起余长(加个一两百)
   */
  final double packUpHeight;

  final Duration hideDuration;
  final Duration showDuration;
  final Curve showCurve;
  final Curve hideCurve;

  /// if set , background is rendered with ImageFilter.blur
  final double blur;

  final ValueChanged<int> onHide;

  /// The style when one menu hide and another menu show ,
  /// see [DropdownMenuShowHideSwitchStyle]
  final DropdownMenuShowHideSwitchStyle switchStyle;

  final double maxMenuHeight;

  DropdownMenu(
      {@required this.menus,
      DropdownMenuController controller,
      Duration hideDuration,
      Duration showDuration,
      this.onHide,
      this.blur,
      this.packUpHeight,
      Key key,
      this.maxMenuHeight,
      Curve hideCurve,
      this.switchStyle: DropdownMenuShowHideSwitchStyle
          .animationShowUntilAnimationHideComplete,
      Curve showCurve})
      : hideDuration = hideDuration ?? new Duration(milliseconds: 150),
        showDuration = showDuration ?? new Duration(milliseconds: 300),
        showCurve = showCurve ?? Curves.fastOutSlowIn,
        hideCurve = hideCurve ?? Curves.fastOutSlowIn,
        super(key: key, controller: controller) {
    assert(menus != null);
  }

  @override
  DropdownState<DropdownMenu> createState() {
    return new _DropdownMenuState(this.packUpHeight);
  }
}

class _DropdownAnimation {
  Animation<Rect> rect;
  AnimationController animationController;
  RectTween position;
  double packUpHeight;
  _DropdownAnimation(TickerProvider provider, double packUpHeight) {
    animationController = new AnimationController(vsync: provider);
    packUpHeight = packUpHeight;
  }

  set height(double value) {
    ///加300防止动画收回时值不够
    position = new RectTween(
      begin: new Rect.fromLTRB(0.0, -value - (packUpHeight ?? 300), 0.0, 0.0),
      end: new Rect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    );
    rect = position.animate(animationController);
  }

  set value(double value) {
    animationController.value = value;
  }

  void dispose() {
    animationController.dispose();
  }

  TickerFuture animateTo(double value, {Duration duration, Curve curve}) {
    return animationController.animateTo(value,
        duration: duration, curve: curve);
  }
}

class SizeClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

class _DropdownMenuState extends DropdownState<DropdownMenu>
    with TickerProviderStateMixin {
  List<_DropdownAnimation> _dropdownAnimations;
  bool _show;
  List<int> _showing;
  final double packUpHeight;
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  _DropdownMenuState(this.packUpHeight);

  @override
  void initState() {
    _showing = [];
    _dropdownAnimations = [];
    for (int i = 0, c = widget.menus.length; i < c; ++i) {
      _dropdownAnimations
          .add(new _DropdownAnimation(this, widget.packUpHeight));
    }

    _updateHeights();

    _show = false;

    _fadeController = new AnimationController(vsync: this);
    _fadeAnimation = new Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_fadeController);

    super.initState();
  }

  @override
  void dispose() {
    for (int i = 0, c = _dropdownAnimations.length; i < c; ++i) {
      _dropdownAnimations[i].dispose();
    }

    super.dispose();
  }

  void _updateHeights() {
    for (int i = 0, c = widget.menus.length; i < c; ++i) {
      _dropdownAnimations[i].height =
          _ensureHeight(_getHeight(widget.menus[i]));
    }
  }

  @override
  void didUpdateWidget(DropdownMenu oldWidget) {
    //update state
    _updateHeights();
    super.didUpdateWidget(oldWidget);
  }

  Widget createMenu(BuildContext context, DropdownMenuBuilder menu, int i) {
    DropdownMenuBuilder builder = menu;

    return new ClipRect(
      clipper: new SizeClipper(),
      child: new SizedBox(
          height: _ensureHeight(builder.height),
          child: _showing.contains(i) ? builder.builder(context) : null),
    );
  }

  Widget _buildBackground(BuildContext context) {
    Widget container = new Container(
//      color: Color.fromARGB(60, 0, 0, 0),
      color: Colors.black12,
    );

    container = new BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: widget.blur ?? 0.0,
          sigmaX: widget.blur ?? 0.0,
        ),
        child: container);

    return container;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    print("build ${new DateTime.now()}");
    Widget _onShowH = FadeTransition(
      opacity: _fadeAnimation,
      child:
          new GestureDetector(onTap: onHide, child: _buildBackground(context)),
    );
    if (_show) {
      list.add(_onShowH);
    }
    for (int i = 0, c = widget.menus.length; i < c; ++i) {
      list.add(new RelativePositionedTransition(
          rect: _dropdownAnimations[i].rect,
          size: new Size(0.0, 0.0),
          child: new Align(
              alignment: Alignment.topCenter,
              child: new Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: createMenu(context, widget.menus[i], i),
              ))));
    }

    //WidgetsBinding;
    //context.findRenderObject();
    return new Stack(
      fit: StackFit.expand,
      children: list,
    );
  }

  TickerFuture onHide({bool dispatch: true}) {
    if (_activeIndex != null) {
      int index = _activeIndex;
      _activeIndex = null;
      TickerFuture future = _hide(index);
      if (dispatch) {
        if (controller != null) {
          controller.hide();
        }

        if (widget.onHide != null) widget.onHide(_activeIndex);
      }

      _fadeController.animateTo(0.0,
          duration: widget.hideDuration, curve: widget.hideCurve);

      future.whenComplete(() {
        setState(() {
          _show = false;
        });
      });
      return future;
    }

    return new TickerFuture.complete();
  }

  TickerFuture _hide(int index) {
    TickerFuture future = _dropdownAnimations[index]
        .animateTo(0.0, duration: widget.hideDuration, curve: widget.hideCurve);
    return future;
  }

  int _activeIndex;

  Future<void> onShow(int index) {
    //哪一个是要展示的

    assert(index >= 0 && index < _dropdownAnimations.length);
    if (!_showing.contains(index)) {
      _showing.add(index);
    }

    if (_activeIndex != null) {
      if (_activeIndex == index) {
        return onHide();
      }

      switch (widget.switchStyle) {
        case DropdownMenuShowHideSwitchStyle.directHideAnimationShow:
          {
            _dropdownAnimations[_activeIndex].value = 0.0;
            _dropdownAnimations[index].value = 1.0;
            _activeIndex = index;

            setState(() {
              _show = true;
            });

            return new Future.value(null);
          }

          break;
        case DropdownMenuShowHideSwitchStyle.animationHideAnimationShow:
          {
            _hide(_activeIndex);
          }
          break;
        case DropdownMenuShowHideSwitchStyle.directHideDirectShow:
          {
            _dropdownAnimations[_activeIndex].value = 0.0;
          }
          break;
        case DropdownMenuShowHideSwitchStyle
            .animationShowUntilAnimationHideComplete:
          {
            return _hide(_activeIndex).whenComplete(() {
              return _handleShow(index, true);
            });
          }
          break;
      }
    }

    return _handleShow(index, true);
  }

  TickerFuture _handleShow(int index, bool animation) {
    _activeIndex = index;

    setState(() {
      _show = true;
    });

    _fadeController.animateTo(1.0,
        duration: widget.showDuration, curve: widget.showCurve);

    return _dropdownAnimations[index]
        .animateTo(1.0, duration: widget.showDuration, curve: widget.showCurve);
  }

  double _getHeight(dynamic menu) {
    DropdownMenuBuilder builder = menu as DropdownMenuBuilder;

    return builder.height;
  }

  double _ensureHeight(double height) {
    final double maxMenuHeight = widget.maxMenuHeight;
    assert(height != null || maxMenuHeight != null,
        "DropdownMenu.maxMenuHeight and DropdownMenuBuilder.height must not both null,| 下拉的高度与下拉内容的高度都要有高度,给一下 ");
    if (maxMenuHeight != null) {
      if (height == null) return maxMenuHeight;
      return height > maxMenuHeight ? maxMenuHeight : height;
    }
    return height;
  }

  @override
  void onEvent(DropdownEvent event) {
    switch (event) {
      case DropdownEvent.SELECT:
      case DropdownEvent.HIDE:
        {
          onHide(dispatch: false);
        }
        break;
      case DropdownEvent.ACTIVE:
        {
          onShow(controller.menuIndex);
        }
        break;
    }
  }
}

class DropdownSliverChildBuilderDelegate
    extends SliverPersistentHeaderDelegate {
  final WidgetBuilder builder;
  final double maxDefinitionExtent;
  final double minDefinitionExtent;

  const DropdownSliverChildBuilderDelegate({
    this.builder,
    this.maxDefinitionExtent,
    this.minDefinitionExtent,
  }) : assert(builder != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(context);
  }

  // TODO: implement maxExtent
  @override
  double get maxExtent => this.maxDefinitionExtent ?? 46.0;

  // TODO: implement minExtent
  @override
  double get minExtent => this.minDefinitionExtent ?? 46.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

///定义多选或者特殊操作时按钮
class FilterButton extends StatelessWidget {
  final VoidCallback resetOnTap;

  ///重置
  final VoidCallback fixOnTap;

  ///确定
  const FilterButton(
      {Key key, @required this.resetOnTap, @required this.fixOnTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    assert(this.resetOnTap != null);
                    this.resetOnTap();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 41.5),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2.0)),
                      ),
                      child: Text(
                        '重置',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )))),
          const SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  assert(this.fixOnTap != null);
                  this.fixOnTap();
                },
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 41.5),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.0)),
                    ),
                    child: Text(
                      '确定',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ))),
          )
        ],
      ),
    );
  }
}

final Color _fontColor = const Color(0XFFC0C4CC);
final double _fontSize = 11;
final Color _labelBgColor = Colors.white;
GlobalKey<_LabelWidgetState> childLabelKey = GlobalKey();

class LabelWidget extends StatefulWidget {
  final Map tagItem;
  final double fontSize;
  final Color fontColor;
  final Widget child;
  final List<BoxShadow> boxShadow;
  final Color labelBgColor;
  final bool isBorder;
  final BoxBorder border;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  const LabelWidget(
      {Key key,
      this.tagItem = const {'name': '标签'},
      this.fontSize,
      this.fontColor,
      this.border,
      this.padding,
      this.isBorder = true,
      this.labelBgColor,
      this.child,
      this.borderRadius,
      this.boxShadow = const [],
      this.alignment})
      : super(key: key);
  @override
  _LabelWidgetState createState() => _LabelWidgetState();
}

class _LabelWidgetState extends State<LabelWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: widget.padding ??
            const EdgeInsets.only(top: .5, bottom: 2.5, left: 4, right: 4),
        alignment: widget.alignment,
        decoration: BoxDecoration(
            color: widget.labelBgColor ?? _labelBgColor,

            /// widget.labelBgColor??_labelBgColor,
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(2.0)),

            ///widget.borderRadius?? BorderRadius.all( Radius.circular(2.0)),
            border: widget.isBorder
                ? widget.border ??
                    Border.all(width: .5, color: const Color(0XFFC0C4CC))
                : null,
            boxShadow: widget.boxShadow.length > 0 ? widget.boxShadow : []),
        child: widget.child ??
            Text(
              widget.tagItem['name'].toString(),
              style: TextStyle(
                  color: widget.fontColor ?? _fontColor,
                  fontSize: widget.fontSize ?? _fontSize),
            ));
  }
}

Widget buildCheckItem(
    BuildContext context, dynamic data, bool selected, String valueKey) {
  return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Text(
            defaultGetItemLabel(data, valueKey),
            style: selected
                ? new TextStyle(
                    fontSize: 14.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400)
                : new TextStyle(fontSize: 14.0),
          ),
          new Expanded(
              child: new Align(
            alignment: Alignment.centerRight,
            child: selected
                ? new Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  )
                : null,
          )),
        ],
      ));
}
