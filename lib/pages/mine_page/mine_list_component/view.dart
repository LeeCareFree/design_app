import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MineListState state, Dispatch dispatch, ViewService viewService) {
  return SliverList(
      delegate: SliverChildListDelegate([
    SizedBox(height: 20),
    _MineListGroup(children: [
      _MineListCell(
        title: '我的日记',
        icon: 'assets/images/diary.png',
        // onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
      ),
    ]),
    SizedBox(height: 5),
    _MineListGroup(children: [
      _MineListCell(
        title: '我的日记',
        icon: 'assets/images/order.png',
        // onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
      ),
    ]),
    SizedBox(height: 5),
    _MineListGroup(children: [
      _MineListCell(
        title: '我的日记',
        icon: 'assets/images/order.png',
        // onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
      ),
    ]),
    SizedBox(height: 5),
    _MineListGroup(children: [
      _MineListCell(
        title: '联系客服',
        icon: 'assets/images/service.png',
        // onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
      ),
    ]),
    SizedBox(height: 5),
    _MineListGroup(children: [
      _MineListCell(
        title: '设置',
        icon: 'assets/images/set.png',
        // onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
      ),
    ]),
  ]));
}

class _MineListGroup extends StatelessWidget {
  final List<Widget> children;
  const _MineListGroup({this.children});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: _theme.primaryColorDark),
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: children),
    );
  }
}

class _MineListCell extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  const _MineListCell(
      {Key key, @required this.title, @required this.icon, this.onTap})
      : assert(title != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        enableFeedback: false,
        onTap: onTap,
        child: Row(children: [
          Container(
            width: Adapt.px(60),
            height: Adapt.px(60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: icon != null
                  ? DecorationImage(fit: BoxFit.cover, image: AssetImage(icon))
                  : null,
            ),
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(fontSize: Adapt.px(26)),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_right,
            color: const Color(0xFF9E9E9E),
          ),
        ]));
  }
}
