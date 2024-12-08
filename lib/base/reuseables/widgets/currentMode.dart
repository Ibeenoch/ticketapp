import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

// class Currentmode extends StatelessWidget {
// const Currentmode({super.key, required this.child});

// final Widget child;
// @override
// Widget build(BuildContext context) {
//   // detect light or dark mode  ${ colorScheme === 'light' ? 'bg-[#f7f7f7]' : 'bg-[#0e1a32]'
//   final isDarkMode =
//       MediaQuery.of(context).platformBrightness == Brightness.dark;
//   final backgroundColor = isDarkMode ? Color(0xFF0E1A32) : Color(0xFFF7F7F7);
//   return Container(
//     color: backgroundColor,
//     child: child,
//   );
// }
// }


