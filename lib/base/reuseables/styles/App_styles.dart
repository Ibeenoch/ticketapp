import 'package:airlineticket/base/reuseables/widgets/currentMode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Color primary = const Color(0xFF687daf);

//{colorScheme === 'light' ? 'bg-[#f7f7f7] border-t-[#0261ef]' : 'bg-[#0e1a32] border-t-[#ffd75b]
class AppStyles {
  // static Color primaryColor = primary;
  static Color textColor = const Color(0xFF3b3b3b);
  static Color bgColor = const Color(0xFFF4F4F4);

  static Color backgroundColorBlue = const Color(0xFF000E28);
  static Color backgroundColorlightBlue = const Color(0xFF0E1A32);
  static Color backgroundColorwhite = const Color(0xFFF7F7F7);

  static Color primaryLightColor = const Color(0xFF0261EF);
  static Color primaryDarkColor = const Color(0xFFFFD75D);
  static Color cardBlueColor = const Color(0xFF526799);
  static Color cardRedColor = const Color(0xFFF37867);

  static Color cardlightkakiColor = const Color(0xFFE6EDFD);
  static Color carddeepOrangeColor = const Color(0xFF526799);
  // static Color cardlightkakiColor = const Color(0xFFFEEBDD);
  // static Color carddeepOrangeColor = const Color(0xFFF0854A);
  static Color kaki = const Color(0xFFd2bdb6);

  static Color primaryColor(BuildContext context) {
    return isDarkMode(context) ? primaryDarkColor : primaryLightColor;
  }

  static Color navHomeColor(BuildContext context) {
    return isDarkMode(context) ? Colors.white : cardBlueColor;
  }

  static Color defaultBackGroundColor(BuildContext context) {
    return isDarkMode(context) ? backgroundColorBlue : Color(0xFFF7F7F7);
  }

  static Color imageUploadColor(BuildContext context) {
    return isDarkMode(context)
        ? Colors.grey.withOpacity(0.2)
        : Colors.black.withOpacity(0.3);
  }

  static Color backGroundColorWhiteAndDeepBlue(BuildContext context) {
    return isDarkMode(context) ? backgroundColorlightBlue : Color(0xFFFFFFFF);
  }

  static Color backGroundOfkakiContainer(BuildContext context) {
    return isDarkMode(context) ? backgroundColorBlue : cardlightkakiColor;
  }

  static Color backGroundOfkakiIconContainer(BuildContext context) {
    return isDarkMode(context) ? Colors.white : carddeepOrangeColor;
  }

  static Color reversedefaultBackGroundColor(BuildContext context) {
    return isDarkMode(context) ? cardRedColor : cardBlueColor;
  }

  static Color borderBackGroundColor(BuildContext context) {
    return isDarkMode(context) ? backgroundColorlightBlue : Colors.white;
  }

  static Color borderlineColor(BuildContext context) {
    return isDarkMode(context)
        ? backgroundColorlightBlue
        : Colors.grey.shade200;
  }

  static Color? skeletonColor(BuildContext context) {
    return isDarkMode(context) ? Colors.grey[600] : Colors.grey[200];
  }

  static Color textWhiteBlack(BuildContext context) {
    return isDarkMode(context) ? Colors.white : Colors.black;
  }

  static Color textredBlue(BuildContext context) {
    return isDarkMode(context) ? cardBlueColor : cardRedColor;
  }

  static Color reversetextWhiteBlack(BuildContext context) {
    return isDarkMode(context) ? Colors.black : Colors.white;
  }

  static Color textWhite(BuildContext context) {
    return Colors.white;
  }

  static Color textGray(BuildContext context) {
    return isDarkMode(context) ? Colors.grey : Colors.grey;
  }

  static TextStyle h1(BuildContext context) {
    return TextStyle(
      fontSize: 22.sp,
      fontWeight: FontWeight.bold,
      color: textWhiteBlack(context),
    );
  }

  static TextStyle h4(BuildContext context) {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
      color: textWhiteBlack(context),
    );
  }

  static TextStyle h3(BuildContext context) {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: cardBlueColor,
    );
  }

  static TextStyle h3White(BuildContext context) {
    return TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: textWhite(context),
    );
  }

  static TextStyle h5(BuildContext context) {
    return TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: primaryColor(context));
  }

  static TextStyle h5White(BuildContext context) {
    return TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: textWhiteBlack(context));
  }
}
