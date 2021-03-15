import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  return _SwiperPanel(
    backdrops: state.backdrops,
    // videos: state.videos,
  );
}

class _SwiperPanel extends StatefulWidget {
  // final List<VideoResult> videos;
  final List<String> backdrops;
  const _SwiperPanel({this.backdrops});
  @override
  _SwiperPanelState createState() => _SwiperPanelState();
}

class _SwiperPanelState extends State<_SwiperPanel> {
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
    final _padding = Adapt.height(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Container(
      height: _height + Adapt.height(30),
      child: Column(
        children: [
          SizedBox(
            height: _height,
            child: Swiper(
              itemCount: widget.backdrops.length,
              autoplay: true,
              onIndexChanged: _setCurrectIndex,
              itemWidth: Adapt.screenW(),
              itemBuilder: (context, index) {
                // if (index == 0 && widget.videos.length > 0) {
                //   return _VideoCell(
                //     videos: widget.videos,
                //   );
                // }
                return _BackDropCell(
                  imageUrl: widget.backdrops.length > index + 1
                      ? widget.backdrops[index]
                      : null,
                );
              },
            ),
          ),
          SizedBox(height: Adapt.height(20)),
          _SwiperPagination(
            lenght: widget.backdrops.length,
            currentIndex: _currentIndex,
          ),
        ],
      ),
    );
  }
}

class _SwiperPagination extends StatelessWidget {
  final int lenght;
  final int currentIndex;
  const _SwiperPagination({this.lenght, this.currentIndex});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _cellWidth = Adapt.width(20);
    final _height = Adapt.height(6);
    final _width =
        lenght > 0 ? _cellWidth * lenght + Adapt.width(10) * (lenght - 1) : 0.0;
    return Container(
        width: _width,
        height: _height,
        child: Align(
          alignment: Alignment.center,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.width(10)),
            itemCount: lenght,
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

class _BackDropCell extends StatelessWidget {
  final String imageUrl;
  const _BackDropCell({this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _padding = Adapt.height(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(20), 0, Adapt.width(20), 0),
      height: _height,
      width: _width,
      decoration: BoxDecoration(
        color: _theme.primaryColorDark,
        borderRadius: BorderRadius.circular(Adapt.radius(25)),
        image: imageUrl != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  imageUrl,
                ),
              )
            : null,
      ),
    );
  }
}
