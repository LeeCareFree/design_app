/*
 * @Author: your name
 * @Date: 2020-10-09 18:38:25
 * @LastEditTime: 2020-10-10 11:07:13
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\header_component\view.dart
 */
import 'package:bluespace/pages/mine_page/action.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      SizedBox(width: Adapt.px(40)),
      Container(
        width: Adapt.px(100),
        height: Adapt.px(100),
        decoration: BoxDecoration(
            color: Color.fromRGBO(242, 225, 217, 1),
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: new ExactAssetImage('assets/images/avatar.png'))),
      ),
      SizedBox(
        width: Adapt.px(20),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.user == null
              ? InkWell(
                  onTap: () => dispatch(MineActionCreator.onLogin()),
                  child: Container(
                      height: Adapt.px(65),
                      width: Adapt.px(200),
                      margin: EdgeInsets.only(
                          right: Adapt.px(30),
                          top: Adapt.px(15),
                          bottom: Adapt.px(15)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Adapt.px(10), vertical: Adapt.px(10)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(30)),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(
                          child: (Text(
                        '请登录',
                        style: TextStyle(
                            color: Colors.black, fontSize: Adapt.px(26)),
                      )))))
              : MaterialButton(
                  child: Text(
                    '请登录',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(35)),
                  ),
                  onPressed: () => {dispatch(MineActionCreator.onLogin())},
                )
        ],
      )
    ],
  );
}
