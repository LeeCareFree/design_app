import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class AppCliper extends CustomClipper<Path> {
  final double radius;
  final double height;
  final double width;

  AppCliper({this.radius, this.height, this.width});

  double degree2Radian(int degree) {
    return (math.pi * degree / 180);
  }

  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, height);
    path.addArc(
        Rect.fromCircle(
            radius: radius, center: Offset(width / 2, height - radius)),
        0,
        180);
    return path;
  }

  @override
  bool shouldReclip(AppCliper oldClipper) {
    return this.radius != oldClipper.radius ||
        this.height != oldClipper.height ||
        this.width != oldClipper.width;
  }
}