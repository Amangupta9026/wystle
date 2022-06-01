import 'package:flex_color_scheme/flex_color_scheme.dart';

class AppTheme {
  static const _scheme = FlexScheme.hippieBlue;

  static final light = FlexThemeData.light(scheme: _scheme);
  static final dark = FlexThemeData.dark(scheme: _scheme);
  static final trueBlack =
      FlexThemeData.dark(scheme: _scheme, darkIsTrueBlack: true);
}
