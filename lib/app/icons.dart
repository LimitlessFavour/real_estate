import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcons {
  CustomIcons._();

  static Widget buildingSvg({double? width, double? height, Color? color}) {
    return _svgIcon('building', width, height, color);
  }

  static Widget candleSvg({double? width, double? height, Color? color}) {
    return _svgIcon('candle', width, height, color);
  }

  static Widget fatrowsSvg({double? width, double? height, Color? color}) {
    return _svgIcon('fatrows', width, height, color);
  }

  static Widget heartSvg({double? width, double? height, Color? color}) {
    return _svgIcon('heart', width, height, color);
  }

  static Widget homeSvg({double? width, double? height, Color? color}) {
    return _svgIcon('home', width, height, color);
  }

  static Widget locationSvg({double? width, double? height, Color? color}) {
    return _svgIcon('location', width, height, color);
  }

  static Widget messageSvg({double? width, double? height, Color? color}) {
    return _svgIcon('message', width, height, color);
  }

  static Widget profileSvg({double? width, double? height, Color? color}) {
    return _svgIcon('profile', width, height, color);
  }

  static Widget rightSvg({double? width, double? height, Color? color}) {
    return _svgIcon('right', width, height, color);
  }

  static Widget searchSvg({double? width, double? height, Color? color}) {
    return _svgIcon('search', width, height, color);
  }

  static Widget zoomSvg({double? width, double? height, Color? color}) {
    return _svgIcon('zoom', width, height, color);
  }

  static Widget _svgIcon(
      String name, double? width, double? height, Color? color) {
    final currentColor = color ?? const Color(0xFF000000);
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: width,
      height: height,
      // theme: SvgTheme(currentColor: currentColor),
      color: currentColor,
    );
  }
}
