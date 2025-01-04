// ignore: file_names
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssetProfilePics extends StatelessWidget {
  const AssetProfilePics({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          image: const DecorationImage(image: AssetImage(AppMedia.logo))),
    );
  }
}
