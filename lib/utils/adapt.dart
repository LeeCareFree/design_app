import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 直接通过`类名称`访问里面的方法，方法为 静态方法
class Adapt {
  static MediaQueryData mediaQuery;
  static double _width;
  static double _height;
  static double _topbarH;
  static double _botbarH;
  static double _pixelRatio;
  static var _ratio;
  static init(context) {
    if (mediaQuery == null) {
      mediaQuery = MediaQuery.of(context);
      _width = mediaQuery.size.width;
      _height = mediaQuery.size.height;
      _topbarH = mediaQuery.padding.top;
      _botbarH = mediaQuery.padding.bottom;
      _pixelRatio = mediaQuery.devicePixelRatio;
    }

    /// 设计稿 --- 宽/高
    // ScreenUtil.init();
    // ScreenUtil.init(width: 750, height: 1334);
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      // 设计尺寸
      Orientation.portrait,
      designSize: Size(750, 1334),
      allowFontScaling: false,
    ); //flutter_screenuitl >= 1.2
  }

  static sp(double value) {
    return ScreenUtil().setSp(value, allowFontScalingSelf: true);

    /// 获取 计算后的字体
  }

  static height(double value) {
    return ScreenUtil().setHeight(value);

    /// 获取 计算后的高度
  }

  static width(double value) {
    return ScreenUtil().setWidth(value);

    /// 获取 计算后的宽度
  }

  static screenH() {
    return ScreenUtil().screenHeight;

    /// 获取 计算后的屏幕高度
  }

  static screenW() {
    return ScreenUtil().screenWidth;
  }

  //根据宽度或高度中的较小者进行调整
  static radius(double value) {
    return ScreenUtil().radius(value);
  }

  static padTopH() {
    return _topbarH;
  }
}
