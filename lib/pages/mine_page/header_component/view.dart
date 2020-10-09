/*
 * @Author: your name
 * @Date: 2020-10-09 18:38:25
 * @LastEditTime: 2020-10-09 18:51:25
 * @LastEditors: your name
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\header_component\view.dart
 */
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      SizedBox(width: Adapt.px(40)),
      Container(
        width: Adapt.px(100),
        height: Adapt.px(100),
        decoration: BoxDecoration(
          color: Color.fromRGBO(242, 225, 217, 1),
          shape: BoxShape.circle,
          image: DecorationImage(fit: BoxFit.cover,image: new ExactAssetImage('assets/images/avatar.png'))
        ),
      ),
      SizedBox(
        width: Adapt.px(20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("请登录",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: Adapt.px(35)
          ),)
        ],
      )
    ],
  );
}
