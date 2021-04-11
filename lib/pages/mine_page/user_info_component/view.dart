/*
 * @Author: your name
 * @Date: 2020-10-09 18:38:25
 * @LastEditTime: 2020-10-10 11:07:13
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \bluespace\lib\pages\mine_page\header_component\view.dart
 */
import 'package:bluespace/models/user_info.dart';
import 'package:bluespace/pages/mine_page/action.dart';
import 'package:bluespace/pages/mine_page/user_info_component/component/user_menu.dart';
import 'package:bluespace/pages/mine_page/user_info_component/state.dart';
// import 'package:bluespace/pages/mine_page/user_info_component/action.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:bluespace/utils/overlay_entry_manage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/adapt.dart';
import '../action.dart';

Widget buildView(
    UserInfoState state, Dispatch dispatch, ViewService viewService) {
  void _closeMenu(OverlayEntry overlayEntry) {
    overlayEntry?.remove();
    state.overlayStateKey.currentState.setOverlayEntry(null);
    overlayEntry = null;
  }

  return _Body(
    isSignIn: state.accountInfo != null,
    user: state.user,
    name: state.accountInfo?.nickname ?? '',
    avatar: state.accountInfo?.avatar ?? '',
    onSignIn: () => dispatch(MineActionCreator.onLogin()),
    overlayStateKey: state.overlayStateKey,
  );
}

class _Body extends StatelessWidget {
  final bool isSignIn;
  final UserInfo user;
  final String name;
  final String avatar;
  final Key overlayStateKey;
  final Function openMenu;
  final Function onSignIn;
  const _Body(
      {this.isSignIn = false,
      this.openMenu,
      this.onSignIn,
      this.user,
      this.name,
      this.avatar,
      this.overlayStateKey});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(0, Adapt.height(30), 0, Adapt.height(30)),
          child: isSignIn
              ? _UserInfo(
                  profileUrl: avatar,
                  userName: name,
                  openMenu: openMenu,
                  overlayStateKey: overlayStateKey)
              : _SignInPanel(
                  onSignIn: onSignIn,
                ),
        ),
      ),
    );
  }
}

class _UserInfo extends StatelessWidget {
  final String userName;
  final String profileUrl;
  final Function openMenu;
  final Key overlayStateKey;
  const _UserInfo(
      {this.profileUrl, this.userName, this.openMenu, this.overlayStateKey});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _avatarMargin = Adapt.height(5);
    final _avatarRadius = Adapt.radius(20);
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '欢迎回来',
              style: TextStyle(color: const Color(0xFF717171), fontSize: 12),
            ),
            SizedBox(height: 5),
            Text(
              userName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Spacer(),
        SizedBox(width: 15),
        Stack(
          children: [
            OverlayEntryManage(
              key: overlayStateKey,
              child: GestureDetector(
                onTap: openMenu,
                child: Container(
                  width: Adapt.width(80),
                  height: Adapt.height(80),
                  margin: EdgeInsets.all(_avatarMargin),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(_avatarRadius),
                    image: profileUrl == null
                        ? null
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(profileUrl),
                          ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.height(80) - _avatarMargin),
              width: Adapt.width(20),
              height: Adapt.height(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF5568E8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SignInPanel extends StatelessWidget {
  final Function onSignIn;
  const _SignInPanel({this.onSignIn});
  @override
  Widget build(BuildContext context) {
    final _iconColor = const Color(0xFF717171);
    return Container(
      height: Adapt.height(90),
      child: Row(children: [
        Icon(
          Icons.notifications,
          size: 18,
          color: _iconColor,
        ),
        Spacer(),
        GestureDetector(
            onTap: onSignIn,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: _iconColor),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(children: [
                Text('登录'),
                SizedBox(width: Adapt.width(15)),
                Icon(
                  Icons.people,
                  color: _iconColor,
                  size: 18,
                ),
              ]),
            ))
      ]),
    );
  }
}
//   return Container(
//       height: Adapt.px(160),
//       margin: EdgeInsets.only(right: Adapt.px(30), left: Adapt.px(30)),
//       decoration: new BoxDecoration(
//           borderRadius: BorderRadius.circular(Adapt.px(20)),
//           color: Colors.grey),
//       child: Row(
//         children: <Widget>[
//           SizedBox(width: Adapt.px(40)),
//           Container(
//             width: Adapt.px(120),
//             height: Adapt.px(120),
//             decoration: BoxDecoration(
//                 color: Color.fromRGBO(242, 225, 217, 1),
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: state.name == '游客'
//                         ? new ExactAssetImage('assets/images/avatar.png')
//                         : new ExactAssetImage('assets/images/avatar.png'))),
//           ),
//           SizedBox(
//             width: Adapt.px(20),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 '${state.name}',
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: Adapt.px(35),
//                 ),
//               ),
//               SizedBox(
//                 height: Adapt.px(10),
//               ),
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () =>
//                         dispatch(MineActionCreator.navigatorPush('关注')),
//                     child: Container(
//                       margin: EdgeInsets.only(right: Adapt.px(30)),
//                       child: Text(
//                         '关注',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: Adapt.px(24),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () =>
//                         dispatch(MineActionCreator.navigatorPush('粉丝')),
//                     child: Container(
//                       child: Text(
//                         '粉丝',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: Adapt.px(24),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           Expanded(child: SizedBox()),
//           state.name == '游客'
//               ? InkWell(
//                   onTap: () => dispatch(MineActionCreator.onLogin()),
//                   child: Container(
//                       height: Adapt.px(65),
//                       width: Adapt.px(200),
//                       alignment: Alignment.center,
//                       margin: EdgeInsets.only(
//                           right: Adapt.px(30),
//                           top: Adapt.px(15),
//                           bottom: Adapt.px(15)),
//                       padding: EdgeInsets.symmetric(
//                           horizontal: Adapt.px(10), vertical: Adapt.px(10)),
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           borderRadius: BorderRadius.circular(Adapt.px(30)),
//                           border: Border.all(color: Colors.black, width: 1)),
//                       child: Text(
//                         '请登录',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: Adapt.px(28),
//                             fontWeight: FontWeight.bold),
//                       )))
//               : PopupMenuButton<String>(
//                   padding: EdgeInsets.zero,
//                   offset: Offset(0, Adapt.px(100)),
//                   icon: Icon(
//                     Icons.more_vert,
//                     color: Colors.black,
//                     size: Adapt.px(50),
//                   ),
//                   onSelected: (selected) {
//                     switch (selected) {
//                       case '退出登录':
//                         // dispatch(MineActionCreator.onLogout());
//                         break;
//                       case '通知':
//                         // dispatch(MineActionCreator.notificationsTapped());
//                         break;
//                     }
//                   },
//                   itemBuilder: (ctx) {
//                     return [
//                       PopupMenuItem<String>(
//                         value: '通知',
//                         child: const _DropDownItem(
//                           title: '通知',
//                           icon: Icons.notifications_none,
//                         ),
//                       ),
//                       PopupMenuItem<String>(
//                         value: '退出登录',
//                         child: const _DropDownItem(
//                           title: '退出登录',
//                           icon: Icons.exit_to_app,
//                         ),
//                       ),
//                     ];
//                   },
//                 ),
//           SizedBox(
//             width: Adapt.px(10),
//           )
//         ],
//       ));
// }

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
