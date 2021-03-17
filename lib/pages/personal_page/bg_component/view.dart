import 'package:bluespace/components/scrollview_background.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(BgState state, Dispatch dispatch, ViewService viewService) {
  final _height = Adapt.height(1150);
  return Builder(
    builder: (context) {
      return SliverToBoxAdapter(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 600),
              child: SizedBox(
                height: _height,
                child: _HeaderBackground(
                  imgUrl: state.bgPic ??
                      'http://192.168.0.105:3000/upload/publish/1.jpeg',
                  scrollController: state.scrollController,
                ),
              ),
            ),
            _UserInfoWidget(
              avatar: 'http://192.168.0.105:3000/imgs/avatar.jpg',
              nickname: 'testnametestname',
            ),
          ],
        ),
      );
    },
  );
}

class _HeaderBackground extends StatefulWidget {
  final String imgUrl;
  final ScrollController scrollController;
  const _HeaderBackground({this.imgUrl, this.scrollController});
  @override
  _HeaderBackgroundState createState() => _HeaderBackgroundState();
}

class _HeaderBackgroundState extends State<_HeaderBackground> {
  double postion = 0;
  final _height = Adapt.height(1150).floorToDouble();
  void _imageScroll() {
    if (widget.scrollController.position.pixels <= _height)
      postion = widget.scrollController.position.pixels;
    setState(() {});
  }

  @override
  void initState() {
    widget.scrollController.addListener(_imageScroll);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_imageScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.imgUrl == null
        ? Container(
            key: ValueKey('bgEmpty'),
            color: const Color(0xFF607D8B),
            width: Adapt.screenW(),
          )
        : Stack(
            children: [
              Container(
                width: Adapt.screenW(),
                key: ValueKey(widget.imgUrl),
                transform: Matrix4.translationValues(0, postion, 0),
                height: _height - postion,
                decoration: BoxDecoration(
                    color: const Color(0xFF607D8B),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(widget.imgUrl))),
              ),
              ScrollViewBackGround(
                scrollController: widget.scrollController,
                height: Adapt.height(750).floorToDouble(),
                maxOpacity: 0.8,
              )
            ],
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
    return Positioned(
        left: 20.0,
        top: 100.0,
        child: Container(
          width: Adapt.screenW(),
          decoration: BoxDecoration(
              color: Colors.transparent,
              //border: Border.all(color: _theme.backgroundColor),
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Adapt.radius(50)))),
          // height: Adapt.height(500),
          // width: Adapt.screenW(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: Image.network(
                    'http://192.168.0.105:3000/imgs/avatar.jpg',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                    // color: Colors.black
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(
                      Adapt.height(20), 0, 0, Adapt.height(60)),
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
                      Text(
                        '关注',
                        style: TextStyle(
                            color: Colors.white, fontSize: Adapt.sp(24)),
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
                        style: TextStyle(
                            color: Colors.white, fontSize: Adapt.sp(24)),
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
                        style: TextStyle(
                            color: Colors.white, fontSize: Adapt.sp(24)),
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
                    padding: EdgeInsets.fromLTRB(Adapt.width(60),
                        Adapt.width(15), Adapt.width(60), Adapt.width(15)),
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
        ));
  }
}
