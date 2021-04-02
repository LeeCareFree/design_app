import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HomeSwiperState state, Dispatch dispatch, ViewService viewService) {
  return _SwiperDiy(
    swiperDataList: state.swiperDataList,
  );
}

class _SwiperDiy extends StatefulWidget {
  final List swiperDataList;
  const _SwiperDiy({this.swiperDataList});
  @override
  _SwiperDiyState createState() => _SwiperDiyState();
}

class _SwiperDiyState extends State<_SwiperDiy> {
  int _currentIndex;
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  _setCurrectIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
        width: Adapt.width(750),
        height: Adapt.height(360),
        child: Column(
          children: [
            SizedBox(
              height: Adapt.height(320),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: Adapt.width(750),
                          height: Adapt.height(55),
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                            child: Text(
                              "${widget.swiperDataList[index].title}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: Adapt.sp(25)),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(Adapt.radius(10)),
                                  bottomRight:
                                      Radius.circular(Adapt.radius(10)))),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${widget.swiperDataList[index].img}"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.all(
                            Radius.circular(Adapt.radius(10)))),
                  );
                },
                itemCount: widget.swiperDataList.length,
                onIndexChanged: _setCurrectIndex,
                autoplay: true,
                viewportFraction: 0.8,
                scale: 0.9,
              ),
            ),
            SizedBox(height: Adapt.height(20)),
            _SwiperPagination(
              length: widget.swiperDataList.length,
              currentIndex: _currentIndex,
            )
          ],
        ));
  }
}

class _SwiperPagination extends StatelessWidget {
  final int length;
  final int currentIndex;
  const _SwiperPagination({this.length, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _cellWidth = Adapt.width(20);
    final _height = Adapt.height(6);
    final _width =
        length > 0 ? _cellWidth * length + Adapt.width(10) * (length - 1) : 0.0;
    return Container(
        width: _width,
        height: _height,
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.width(10)),
            itemCount: length,
            itemBuilder: (_, index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _cellWidth,
                height: _height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_height / 2),
                  color: index == currentIndex
                      ? _theme.iconTheme.color
                      : _theme.primaryColorDark,
                ),
              );
            },
          ),
        ));
  }
}
