import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightUpCard extends StatelessWidget {
  const RightUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width * 0.44,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppStyles.cardBlueColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Discount For\nTicket Survey',
                style: AppStyles.h3White(context),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Take a short survey about our service  and get a discount',
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Positioned(
            top: -45,
            right: -50,
            child: Container(
              padding: EdgeInsets.all(30.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 18.w, color: Color(0xFFF37867).withOpacity(0.4)),
                  shape: BoxShape.circle),
            ))
      ],
    );
  }
}
