import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PublishState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[_LeftAppBar(), _RightAppBar()],
    ),
  );
}

class _LeftAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}

class _RightAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 0.0,
        // left: 0.0,
        right: 0.0,
        child: TextButton(
          child: Text('11'),
        ));
  }
}
