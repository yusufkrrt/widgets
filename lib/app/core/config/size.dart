import 'package:flutter/material.dart';

class SizeConfig {
  SizeConfig._();

  static double getScaleFactor(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 1.0;
    if (width < 900) return 1.2;
    if (width < 1200) return 1.3;
    if (width < 1800) return 1.4;
    return 1.4;
  }

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1023;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
}
