import 'package:flutter/material.dart';

import 'lib_color_schemes.dart';

/// 主题
class AppTheme {
  /// 亮色
  static ThemeData light = ThemeData(
    colorScheme: lightColorScheme,
  );

  /// 暗色
  static ThemeData dark = ThemeData(
    colorScheme: darkColorScheme,
  );
}
