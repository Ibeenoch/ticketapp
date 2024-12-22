import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Arrivaltype extends StatelessWidget {
  const Arrivaltype({super.key, required this.text, required this.icon});
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Row(
          children: [
            Icon(
              // Icons.flight_takeoff,
              icon,
              color: Colors.grey,
              size: 17.sp,
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
