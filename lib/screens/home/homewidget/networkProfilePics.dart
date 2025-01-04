import 'package:airlineticket/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NetworkProfilePics extends StatelessWidget {
  final String profileImg;
  const NetworkProfilePics({super.key, required this.profileImg});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.profileScreen);
      },
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.r),
            image: DecorationImage(
                image: NetworkImage(profileImg), fit: BoxFit.cover)),
      ),
    );
  }
}
