import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AppSettingState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: AppBar(
        iconTheme: _theme.iconTheme,
        elevation: 3.0,
        backgroundColor: _theme.bottomAppBarColor,
        brightness: _theme.brightness,
        title: Text(
          '设置',
          style: TextStyle(color: Colors.black, fontSize: Adapt.sp(32)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            _Menu(
              text: "退出登录",
              press: () => dispatch(AppSettingActionCreator.logout()),
            ),
          ],
        ),
      ));
}

class _Menu extends StatelessWidget {
  final Function press;
  final String text;
  const _Menu({this.press, this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(
          children: [
            Icon(Icons.logout),
            SizedBox(width: 20),
            Expanded(child: Text(text)),
            Icon(Icons.chevron_right_outlined),
          ],
        ),
      ),
    );
  }
}
