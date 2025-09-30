import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dimension_utils.dart';

class StyleUtils {
  static TextStyle titleLarge = TextStyle(
    fontSize: DimensionUtils.FONT_SIZE_TITLE_LARGE,
    fontWeight: FontWeight.bold,
  );
  static TextStyle button = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
  );

  static TextStyle buttonLink = TextStyle(
    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
    color: Colors.blueAccent,
  );

  static TextStyle styleDefault = TextStyle(
    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
  );
  static TextStyle styleTitleDefault = TextStyle(
    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
  );

  static DefaultTextStyle defaultTextStyle(
      {required String text, TextStyle? style}) {
    return DefaultTextStyle(
      style: style ??
          styleDefault.copyWith(
            color: Theme.of(Get.context!).primaryColorLight,
          ),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
