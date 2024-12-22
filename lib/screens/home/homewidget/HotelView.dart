import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/screens/home/homewidget/hotelText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Hotelview extends StatelessWidget {
  final Map<String, dynamic> hotelItem;
  const Hotelview({super.key, required this.hotelItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Container(
        width: size.width * 0.6,
        height: 300.h,
        decoration: BoxDecoration(
            color: AppStyles.cardBlueColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Container(
                height: 180.h,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: AppStyles.cardBlueColor,
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      image: AssetImage('assets/images/${hotelItem['image']}'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Hoteltext(
              text: hotelItem['name'],
              color: AppStyles.kaki,
            ),
            SizedBox(
              height: 5.h,
            ),
            Hoteltext(
              text: hotelItem['location'],
              sizeType: 'h4',
              weightType: 'normal',
            ),
            SizedBox(
              height: 5.h,
            ),
            Hoteltext(
              text: '\$${hotelItem['amount'].toString()}/Night',
              color: AppStyles.kaki,
              sizeType: 'h4',
              weightType: 'normal',
            ),
          ],
        ),
      ),
    );
  }
}
