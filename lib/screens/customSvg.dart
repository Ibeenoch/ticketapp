import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvg extends StatelessWidget {
  const CustomSvg({super.key, required this.svgpath});

  final String svgpath;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SvgPicture.asset(
      svgpath,
      width: 25,
      height: 25,
    );
  }
}
