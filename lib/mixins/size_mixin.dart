import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';

mixin SizeMixin<T extends StatefulWidget> on State<T> {
  double maxHeight(
    BoxConstraints constraints, {
    double? offsetPercent,
    double? offsetPercentDesktop,
    double? offsetPercentMobile,
    double? offsetPercentTablet,
  }) =>
      constraints.maxHeight != double.infinity
          ? constraints.maxHeight
          : _applyOffset(
              context.dimen.height,
              offsetPercent,
              offsetPercentDesktop,
              offsetPercentMobile,
              offsetPercentTablet,
            );

  double maxWidth(
    BoxConstraints constraints, {
    double? offsetPercent,
    double? offsetPercentDesktop,
    double? offsetPercentMobile,
    double? offsetPercentTablet,
  }) =>
      constraints.maxWidth != double.infinity
          ? constraints.maxWidth
          : _applyOffset(
              context.dimen.width,
              offsetPercent,
              offsetPercentDesktop,
              offsetPercentMobile,
              offsetPercentTablet,
            );

  double _applyOffset(
    double value,
    double? offsetPercent,
    double? offsetPercentDesktop,
    double? offsetPercentMobile,
    double? offsetPercentTablet,
  ) {
    if (context.isDesktop) {
      if (offsetPercentDesktop != null) {
        return value * offsetPercentDesktop;
      } else if (offsetPercent != null) {
        return value * offsetPercent;
      }
      return value;
    }

    if (context.isTablet) {
      if (offsetPercentTablet != null) {
        return value * offsetPercentTablet;
      } else if (offsetPercent != null) {
        return value * offsetPercent;
      }
      return value;
    }

    if (offsetPercentMobile != null) {
      return value * offsetPercentMobile;
    } else if (offsetPercent != null) {
      return value * offsetPercent;
    }
    return value;
  }

  double get height => context.dimen.height;

  double get width => context.dimen.width;

  bool get isMobile => context.isMobile;

  bool get isDesktop => context.isDesktop;

  bool get isTablet => context.isTablet;
}
