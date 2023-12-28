import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    if (blockSizeVertical > 10) {
      blockSizeHorizontal = blockSizeHorizontal - 2.8;
    } else if (blockSizeVertical < 6 && blockSizeHorizontal > 9) {
      blockSizeHorizontal = blockSizeHorizontal - 2;
    } else if (blockSizeVertical > 9 && blockSizeHorizontal > 17) {
      blockSizeHorizontal = blockSizeHorizontal - 3;
    }
  }
}
