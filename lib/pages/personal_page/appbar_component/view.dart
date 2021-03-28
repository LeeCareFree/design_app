import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(
    AppBarState state, Dispatch dispatch, ViewService viewService) {
  return _CustomAppBar(
    title: state.title ?? '',
    controller: state.scrollController,
    // menuPress: () => dispatch(MovieDetailPageActionCreator.openMenu()),
  );
}

class _CustomAppBar extends StatefulWidget {
  final ScrollController controller;
  final String title;
  final Function menuPress;
  const _CustomAppBar({this.controller, this.title, this.menuPress});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<_CustomAppBar> {
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
                'http://192.168.0.103:3000/avatar/lee.jpg',
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
              Adapt.width(80), Adapt.height(150), 0, Adapt.height(0)),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  'http://192.168.0.103:3000/upload/publish/Screenshot_20210314_133329.jpg',
                )),
          ),
          child: _UserInfoWidget(),
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
  final String avatar;
  final String nickname;
  const _UserInfoWidget({this.avatar, this.nickname});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
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
          children: [
            ClipOval(
              child: Image.network(
                'http://192.168.0.103:3000/imgs/avatar.jpg',
                fit: BoxFit.cover,
                width: 100,
                height: 100,
                // color: Colors.black
              ),
            ),
            Container(
              padding:
                  EdgeInsets.fromLTRB(Adapt.height(20), 0, 0, Adapt.height(60)),
              child: Text(
                nickname ?? '',
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
          height: Adapt.height(30),
        ),
        Row(
          children: [
            InkWell(
              onTap: () => {},
              child: Column(
                children: [
                  Text(
                    '666',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.sp(30),
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '关注',
                      style: TextStyle(
                          color: Colors.white, fontSize: Adapt.sp(24)),
                    ),
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
                    '666',
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
                    '666',
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
              width: Adapt.width(100),
            ),
            InkWell(
              onTap: () => {},
              child: Container(
                padding: EdgeInsets.fromLTRB(Adapt.width(60), Adapt.width(15),
                    Adapt.width(60), Adapt.width(15)),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(Adapt.radius(50))),
                child: Text(
                  '关注',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.sms_outlined,
                  color: Colors.white,
                ),
                onPressed: () => {})
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
