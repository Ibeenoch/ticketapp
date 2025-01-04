// ignore: file_names
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderText extends StatelessWidget {
  final String username;
  const HeaderText({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning,',
          style: AppStyles.h5(context),
        ),
        Text(
          username,
          style: AppStyles.h5(context),
        ),
        SizedBox(
          height: 10.h,
        ),
        Text('Wanna Buy Ticket?',
            style: AppStyles.h3(context).copyWith(fontSize: 14.sp))
      ],
    );
  }
}
