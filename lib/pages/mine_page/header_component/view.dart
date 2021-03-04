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
import '../../../utils/adapt.dart';
import '../action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Container(
      height: Adapt.px(160),
      margin: EdgeInsets.only(right: Adapt.px(30), left: Adapt.px(30)),
      decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          color: Colors.grey),
      child: Row(
        children: <Widget>[
          SizedBox(width: Adapt.px(40)),
          Container(
            width: Adapt.px(120),
            height: Adapt.px(120),
            decoration: BoxDecoration(
                color: Color.fromRGBO(242, 225, 217, 1),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: state.name == '游客'
                        ? new ExactAssetImage('assets/images/avatar.png')
                        : new ExactAssetImage('assets/images/avatar.png'))),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${state.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Adapt.px(35),
                ),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        dispatch(MineActionCreator.navigatorPush('关注')),
                    child: Container(
                      margin: EdgeInsets.only(right: Adapt.px(30)),
                      child: Text(
                        '关注',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Adapt.px(24),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        dispatch(MineActionCreator.navigatorPush('粉丝')),
                    child: Container(
                      child: Text(
                        '粉丝',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Adapt.px(24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          state.name == '游客'
              ? InkWell(
                  onTap: () => dispatch(MineActionCreator.onLogin()),
                  child: Container(
                      height: Adapt.px(65),
                      width: Adapt.px(200),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          right: Adapt.px(30),
                          top: Adapt.px(15),
                          bottom: Adapt.px(15)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Adapt.px(10), vertical: Adapt.px(10)),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(Adapt.px(30)),
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Text(
                        '请登录',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Adapt.px(28),
                            fontWeight: FontWeight.bold),
                      )))
              : PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  offset: Offset(0, Adapt.px(100)),
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: Adapt.px(50),
                  ),
                  onSelected: (selected) {
                    switch (selected) {
                      case '退出登录':
                        // dispatch(MineActionCreator.onLogout());
                        break;
                      case '通知':
                        // dispatch(MineActionCreator.notificationsTapped());
                        break;
                    }
                  },
                  itemBuilder: (ctx) {
                    return [
                      PopupMenuItem<String>(
                        value: '通知',
                        child: const _DropDownItem(
                          title: '通知',
                          icon: Icons.notifications_none,
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: '退出登录',
                        child: const _DropDownItem(
                          title: '退出登录',
                          icon: Icons.exit_to_app,
                        ),
                      ),
                    ];
                  },
                ),
          SizedBox(
            width: Adapt.px(10),
          )
        ],
      ));
}

class _DropDownItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const _DropDownItem({@required this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Icon(icon), SizedBox(width: 10), Text(title)],
    );
  }
}
