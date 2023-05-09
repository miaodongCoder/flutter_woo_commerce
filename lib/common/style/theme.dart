import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'lib_color_schemes.dart';

/// 主题
class AppTheme {
  /// 亮色
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
  );

  /// 暗色
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
    fontFamily: "Montserrat",
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
