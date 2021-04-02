import 'package:bluespace/models/account_info.dart';
import 'package:bluespace/pages/personal_page/action.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final ScrollController controller;
  final AccountInfo accountInfo;
  final Function menuPress;
  final String uid;
  final bool isFollow;
  final Dispatch dispatch;
  const CustomAppBar(
      {this.controller,
      this.accountInfo,
      this.menuPress,
      this.uid,
      this.isFollow,
      this.dispatch});
  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  bool showBar = false;
  double _opacity = 0.0;
  final double _opacityHeight = Adapt.height(300);
  final double _appBarChangeHeight = Adapt.height(200);
  final double _totalHeight = Adapt.height(900);
  void _checkTitle() {
    if (widget.controller.position.pixels >= _appBarChangeHeight) {
      double v =
          _opacityHeight - (_totalHeight - widget.controller.position.pixels);
      v = v > _opacityHeight || v < 0 ? _opacityHeight : v;
      _opacity = v / _opacityHeight;
      showBar = true;
    } else {
      showBar = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_checkTitle);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkTitle);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return SliverAppBar(
      pinned: true,
      floating: false,
      snap: false,
      elevation: 0,
      // leading: backIcon(context),
      expandedHeight: Adapt.height(400),
      title: showBar
          ? ClipOval(
              child: Image.network(
                widget.accountInfo?.avatar ?? '',
                fit: BoxFit.cover,
                width: 35,
                height: 35,
                // color: Colors.black
              ),
            )
          : null,
      onStretchTrigger: () async {
        return;
      },
      actions: [
        IconButton(icon: Icon(Icons.share_outlined), onPressed: () => {})
      ],
      backgroundColor: _theme.bottomAppBarColor,
      stretch: true, //是否可拉伸伸展
      stretchTriggerOffset: Adapt.height(100), //触发拉伸偏移量
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.fromLTRB(
              Adapt.width(50), Adapt.height(150), 0, Adapt.height(0)),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  'http://8.129.214.128:3001/upload/publish/Screenshot_20210314_133329.jpg',
                )),
          ),
          child: _UserInfoWidget(
            uid: widget.uid,
            accountInfo: widget.accountInfo,
            isFollow: widget.isFollow ?? false,
            dispatch: widget.dispatch,
          ),
        ),
        stretchModes: const <StretchMode>[
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
        ],
      ),
    );
  }
}

class _UserInfoWidget extends StatelessWidget {
  final String uid;
  final AccountInfo accountInfo;
  final bool isFollow;
  final Dispatch dispatch;
  const _UserInfoWidget(
      {this.accountInfo, this.uid, this.isFollow, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      margin: EdgeInsets.only(top: Adapt.height(60)),
      width: Adapt.screenW(),
      decoration: BoxDecoration(
          color: Colors.transparent,
          //border: Border.all(color: _theme.backgroundColor),
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(Adapt.radius(50)))),
      // height: Adapt.height(500),
      // width: Adapt.screenW(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.network(
                accountInfo?.avatar ?? '',
                fit: BoxFit.cover,
                width: 50,
                height: 50,
                // color: Colors.black
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(Adapt.width(20), 0, 0, 0),
              child: Text(
                accountInfo?.nickname ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: Adapt.sp(40),
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(
          height: Adapt.height(20),
        ),
        Text(
          '诗长满羽毛栖息在窗台',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: Adapt.height(20),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed('userListPage',
                    arguments: {'type': 'follow', 'uid': accountInfo?.uid})
              },
              child: Column(
                children: [
                  Text(
                    accountInfo?.followNum.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.sp(30),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '关注',
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.sp(24)),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Adapt.width(30),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.of(context).pushNamed('userListPage',
                    arguments: {'type': 'fans', 'uid': accountInfo?.uid})
              },
              child: Column(
                children: [
                  Text(
                    accountInfo?.fansNum.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.sp(30),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '粉丝',
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.sp(24)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Adapt.width(30),
            ),
            InkWell(
              onTap: () => {},
              child: Column(
                children: [
                  Text(
                    accountInfo?.likeColl.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.sp(30),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '获赞与收藏',
                    style:
                        TextStyle(color: Colors.white, fontSize: Adapt.sp(24)),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Adapt.width(40),
            ),
            uid == accountInfo?.uid
                ? InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(Adapt.width(40),
                          Adapt.width(10), Adapt.width(40), Adapt.width(10)),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius:
                              BorderRadius.circular(Adapt.radius(50))),
                      child: Text(
                        '编辑资料',
                        style: TextStyle(
                            fontSize: Adapt.sp(24), color: Colors.white),
                      ),
                    ),
                  )
                : Container(
                    child: isFollow
                        ? InkWell(
                            onTap: () => {
                              dispatch(PersonalActionCreator.follow('cancel'))
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  Adapt.width(40),
                                  Adapt.width(10),
                                  Adapt.width(40),
                                  Adapt.width(10)),
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius:
                                      BorderRadius.circular(Adapt.radius(50))),
                              child: Text(
                                '已关注',
                                style: TextStyle(
                                    fontSize: Adapt.sp(24),
                                    color: Colors.grey[400]),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () =>
                                {dispatch(PersonalActionCreator.follow('add'))},
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                  Adapt.width(40),
                                  Adapt.width(10),
                                  Adapt.width(40),
                                  Adapt.width(10)),
                              decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius:
                                      BorderRadius.circular(Adapt.radius(50))),
                              child: Text(
                                '关注',
                                style: TextStyle(
                                    fontSize: Adapt.sp(24),
                                    color: Colors.white),
                              ),
                            ),
                          ),
                  ),
            SizedBox(
              width: Adapt.width(30),
            ),
            uid == accountInfo?.uid
                ? InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(Adapt.width(20),
                          Adapt.width(10), Adapt.width(20), Adapt.width(10)),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius:
                              BorderRadius.circular(Adapt.radius(50))),
                      child: Row(
                        children: [
                          Text(
                            '设置',
                            style: TextStyle(
                                fontSize: Adapt.sp(24), color: Colors.white),
                          ),
                          SizedBox(
                            width: Adapt.width(10),
                          ),
                          Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(Adapt.width(20),
                          Adapt.width(10), Adapt.width(20), Adapt.width(10)),
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius:
                              BorderRadius.circular(Adapt.radius(50))),
                      child: Row(
                        children: [
                          Text(
                            '发消息',
                            style: TextStyle(
                                fontSize: Adapt.sp(24), color: Colors.white),
                          ),
                          SizedBox(
                            width: Adapt.width(10),
                          ),
                          Icon(
                            Icons.sms_outlined,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                  )
          ],
        )
        // _ExternalGroup(
        //   dispatch: dispatch,
        //   externalIds: externalIds,
        //   homePage: homePage,
        // )
      ]),
    );
  }
}
