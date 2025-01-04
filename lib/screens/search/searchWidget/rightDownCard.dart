import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/screens/search/searchWidget/EmojiContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RightDownCard extends StatelessWidget {
  const RightDownCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.44,
      height: 150.h,
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
          color: AppStyles.cardRedColor,
          borderRadius: BorderRadius.circular(15.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Show Support',
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'We appreciate your support for our service',
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Emojicontainer(text: '🥰'),
                Emojicontainer(text: '😍'),
                Emojicontainer(text: '🤗'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
