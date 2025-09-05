import 'package:flutter/material.dart';
import 'package:mandir/utils/const.dart';
import 'package:get/get.dart';

class SizeConfig {
  static SizeConfig? _instance;

  static SizeConfig get instance {
    _instance ??= SizeConfig.init();
    return _instance!;
  }

  late double screenWidth;
  late double screenHeight;
  late double blockSizeHorizontal;
  late double blockSizeVertical;

  late double _safeAreaHorizontal;
  late double _safeAreaVertical;
  late double safeBlockHorizontal;
  late double safeBlockVertical;

  static initWithContext(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    instance.screenWidth =
    PlatformType.isWeb ? Const.webWidth : mediaQueryData.size.width;
    instance.screenHeight = mediaQueryData.size.height;
    instance.blockSizeHorizontal = instance.screenWidth / 100;
    instance.blockSizeVertical = instance.screenHeight / 100;

    instance._safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    instance._safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    instance.safeBlockHorizontal =
        (instance.screenWidth - instance._safeAreaHorizontal) / 100;
    instance.safeBlockVertical =
        (instance.screenHeight - instance._safeAreaVertical) / 100;
  }

  SizeConfig.init() {
    MediaQueryData _mediaQueryData = Get.context!.mediaQuery;
    screenWidth =
    PlatformType.isWeb ? Const.webWidth : _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

extension SizeExtOnDouble on num {
  double get w => this * SizeConfig.instance.safeBlockHorizontal;

  double get h => this * SizeConfig.instance.safeBlockVertical;

  Widget get vs => SizedBox(width: 0, height: this.toDouble());

  Widget get hs => SizedBox(width: this.toDouble(), height: 0);
}
