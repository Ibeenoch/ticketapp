import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotelImage extends StatelessWidget {
  final Map<String, dynamic> getHostel;
  const HotelImage({super.key, required this.getHostel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned.fill(
          child: Image(
            image: NetworkImage(getHostel['imageList'][0]),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 20.h,
          right: size.width * 0.4,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.sp, vertical: 7.sp),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(6.r)),
              child: Text(
                getHostel['name'],
                style: TextStyle(
                    fontSize: 14.sp, color: Colors.white.withOpacity(0.8)),
              )),
        )
      ],
    );
  }
}
