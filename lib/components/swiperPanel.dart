import 'package:bluespace/components/fitImage.dart';
import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperPanel extends StatefulWidget {
  // final List<VideoResult> videos;
  final List<String> backdrops;
  const SwiperPanel({this.backdrops});
  @override
  SwiperPanelState createState() => SwiperPanelState();
}

class SwiperPanelState extends State<SwiperPanel> {
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
    final _height = _width * 9 / 6;
    return Container(
      height: _height + Adapt.height(30),
      child: Column(
        children: [
          SizedBox(
            height: _height,
            child: Swiper(
              itemCount: widget.backdrops.length,
              // autoplay: false,
              // autoplayDisableOnInteraction: true,
              onIndexChanged: _setCurrectIndex,
              itemWidth: Adapt.screenW(),
              itemBuilder: (context, index) {
                return _BackDropCell(
                  imageUrl: widget.backdrops.length >= index + 1
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
    print(imageUrl);
    final _theme = ThemeStyle.getTheme(context);
    final _padding = Adapt.height(40);
    final _width = Adapt.screenW() - _padding * 2;
    final _height = _width * 9 / 16;
    return Container(
      margin: EdgeInsets.fromLTRB(Adapt.width(20), 0, Adapt.width(20), 0),
      height: _height,
      width: _width,
      child: ItemFitWidthNetImage(imageUrl, Adapt.screenW() - Adapt.width(60)),
    );
  }
}
