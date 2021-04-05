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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(Adapt.radius(30))),
      margin: EdgeInsets.all(Adapt.height(30)),
      child: TextButton(
        onPressed: press,
        child: Row(
          children: [
            Icon(Icons.logout, color: Colors.black54),
            SizedBox(width: 20),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: Colors.black54),
            )),
            Icon(Icons.chevron_right_outlined, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
