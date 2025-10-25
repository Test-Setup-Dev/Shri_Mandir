import 'package:flutter/material.dart';

class ThemeColors {
  // static const int _primary = 0xFF1B917D;
  static const int _primary = 0xFFF25309;
  static const int _r = 255;
  static const int _g = 86;
  static const int _b = 40;

  static const int _secondary = 0xFFD85F3B;
  static const int _sr = 248;
  static const int _sg = 50;
  static const int _sb = 146;

  static const Map<int, Color> _color = {
    50: Color.fromRGBO(_r, _g, _b, .1),
    100: Color.fromRGBO(_r, _g, _b, .2),
    200: Color.fromRGBO(_r, _g, _b, .3),
    300: Color.fromRGBO(_r, _g, _b, .4),
    400: Color.fromRGBO(_r, _g, _b, .5),
    500: Color.fromRGBO(_r, _g, _b, .6),
    600: Color.fromRGBO(_r, _g, _b, .7),
    700: Color.fromRGBO(_r, _g, _b, .8),
    800: Color.fromRGBO(_r, _g, _b, .9),
    900: Color.fromRGBO(_r, _g, _b, 1),
  };

  static const Map<int, Color> _secondaryColor = {
    50: Color.fromRGBO(_sr, _sg, _sb, .1),
    100: Color.fromRGBO(_sr, _sg, _sb, .2),
    200: Color.fromRGBO(_sr, _sg, _sb, .3),
    300: Color.fromRGBO(_sr, _sg, _sb, .4),
    400: Color.fromRGBO(_sr, _sg, _sb, .5),
    500: Color.fromRGBO(_sr, _sg, _sb, .6),
    600: Color.fromRGBO(_sr, _sg, _sb, .7),
    700: Color.fromRGBO(_sr, _sg, _sb, .8),
    800: Color.fromRGBO(_sr, _sg, _sb, .9),
    900: Color.fromRGBO(_sr, _sg, _sb, 1),
  };

  // Changed from dark theme
  static const Color primary2 = Color(0xFFF8F9FA); // Light gray instead of dark

  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static const Color blue = Color(0xFF1F4FBD);

  // Changed from dark theme - now using white for cards/containers
  static const Color drawerColor = Color(0xFFFFFFFF); // White instead of dark

  static const Color lightBlue = Color(0xFF1F8EE0);
  static const Color whiteBlue = Color.fromARGB(255, 242, 243, 248);
  static const Color offWhite = Color.fromARGB(255, 251, 252, 254);

  // Main background is now white
  static const Color backgroundColor = white;

  static const MaterialColor primaryColor = MaterialColor(_primary, _color);
  static const MaterialColor colorSecondary =
  MaterialColor(_secondary, _secondaryColor);
  static const Color accentColor = Color.fromRGBO(243, 71, 28, 1);

  // Main text color for light theme
  static const Color defaultTextColor = Color.fromRGBO(32, 36, 37, 1.0);

  // Light theme shimmer colors
  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;
  static Color greyColor = Colors.blueGrey;

  // Secondary text color for light theme - darker gray
  static Color textPrimaryColor = Colors.grey.shade600;

  static Color verifiedColor = const Color(0xFF10B981);
  static Color unVerifiedColor = const Color(0xFFF59E0B);

  static const Color purple = Color.fromRGBO(93, 45, 182, 1.0);
  static const Color transparentColor = Colors.transparent;

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    colors: <Color>[primaryColor, primaryColor],
    tileMode: TileMode.clamp,
  );

  static LinearGradient gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Colors.grey.shade50],
  );
}