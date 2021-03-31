import 'package:bluespace/style/themeStyle.dart';
import 'package:bluespace/utils/adapt.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final _theme = ThemeStyle.getTheme(context);
    return Scaffold(
      backgroundColor: const Color(0xFFEDF6FD),
      // backgroundColor: Colors.grey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: _theme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.width(40)),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: Adapt.height(35),
                crossAxisSpacing: Adapt.width(35),
                childAspectRatio: 1.2,
                children: [
                  SizedBox(height: Adapt.height(10)),
                  SizedBox(height: Adapt.height(10)),
                  SizedBox(height: Adapt.height(10)),
                  SizedBox(height: Adapt.height(10)),
                  _FeaturesCell(
                    title: '发布装修',
                    subTitle: '寻找心仪的设计',
                    icon: 'assets/images/publish.png',
                    onTap: () =>
                        {Navigator.of(context).pushNamed('decoratePage')},
                  ),
                  _FeaturesCell(
                    title: '写日记',
                    subTitle: '记录装修历程',
                    icon: 'assets/images/diary.png',
                    onTap: () => {},
                  ),
                  _FeaturesCell(
                      title: '晒图',
                      subTitle: '分享装修美图',
                      icon: 'assets/images/showImg.png',
                      onTap: () => showDialog(
                          context: viewService.context,
                          builder: (_) => _ImagePickerDialog(
                                data: ['拍照', '选取照片'],
                                onTap: (d) => dispatch(
                                    CreateActionCreator.onShowImgClicked(d)),
                                selected: state.selectedVal,
                              ))),
                  _FeaturesCell(
                      title: '晒视频',
                      subTitle: '分享装修视频',
                      icon: 'assets/images/showVideo.png',
                      onTap: () => showDialog(
                          context: viewService.context,
                          builder: (_) => _ImagePickerDialog(
                                data: ['拍视频', '选取视频'],
                                onTap: (d) => dispatch(
                                    CreateActionCreator.onShowVideoClicked(d)),
                                selected: state.selectedVal,
                              ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

class _FeaturesCell extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function onTap;
  final String icon;
  const _FeaturesCell({this.title, this.subTitle, this.onTap, this.icon});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: _theme.primaryColorDark),
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: Adapt.sp(32),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: Adapt.sp(22),
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF717171),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: Adapt.height(15)),
              width: Adapt.width(80),
              height: Adapt.height(60),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: icon != null
                    ? DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(icon),
                      )
                    : null,
              ),
            ),
            SizedBox(height: Adapt.height(10)),
          ],
        ),
      ),
    );
  }
}

// 照片弹窗
class _ImagePickerDialog extends StatelessWidget {
  final Function onTap;
  final String selected;
  final List<String> data;
  const _ImagePickerDialog({this.onTap, this.selected, this.data});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    return Container(
      height: _size.height,
      width: _size.width,
      child: SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 0.0,
        backgroundColor: _backGroundColor,
        titleTextStyle: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 18),
        title: Text(
          '请选择',
        ),
        children: [
          Container(
            height: _size.height / 7,
            width: _size.width,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
              separatorBuilder: (_, __) => SizedBox(height: 10),
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final _selected = data[index];
                return _SelectListCell(
                  onTap: (l) => onTap(l),
                  selected: selected == _selected,
                  option: _selected,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectListCell extends StatelessWidget {
  final Function onTap;
  final String option;
  final bool selected;
  const _SelectListCell({this.onTap, this.option, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(option);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFFFFFFFF)))
            : null,
        child: Text(
          option,
          style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 14),
        ),
      ),
    );
  }
}
