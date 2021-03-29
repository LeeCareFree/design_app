import 'package:bluespace/components/asperctRaioImage.dart';
import 'package:flutter/cupertino.dart';

///宽度自适应的图片
// ignore: non_constant_identifier_names
Widget ItemFitWidthNetImage(String url, double fitWidth) {
  return AsperctRaioImage.network(url, builder: (context, snapshot, url) {
    //计算缩放
    double scale = snapshot.data.width.toDouble() / fitWidth;
    double fitHeight = snapshot.data.height.toDouble() / scale;
    return Container(
      width: fitWidth,
      height: fitHeight,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  });
}
