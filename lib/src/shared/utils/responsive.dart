import 'package:flutter/material.dart';

const _kBaseWidth = 390.0;

extension Responsive on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  bool get isTablet => screenWidth >= 600;

  double r(double size) => size * screenWidth / _kBaseWidth;

  double sp(double size) => size * screenWidth / _kBaseWidth;

  double wp(double percent) => screenWidth * percent / 100;

  double hp(double percent) => screenHeight * percent / 100;
}
