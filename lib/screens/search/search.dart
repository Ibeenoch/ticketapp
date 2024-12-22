import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/symmetricText.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/screens/search/searchWidget/EmojiContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final departure = TextEditingController();
  FocusNode departure_F = FocusNode();

  final arrival = TextEditingController();
  FocusNode arrival_F = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: ListView(
          children: [
            Text(
              'What Are\nYou Looking For?',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.textWhiteBlack(context)),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child:
                  const Tickettab(leftText: 'All Tickets', rightText: 'Hotels'),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: Colors.white),
              child: TextField(
                style:
                    TextStyle(color: AppStyles.cardBlueColor, fontSize: 12.sp),
                controller: departure,
                focusNode: departure_F,
                cursorColor: AppStyles.cardBlueColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.flight_takeoff,
                      color: departure_F.hasFocus
                          ? AppStyles.cardBlueColor
                          : Colors.grey,
                      size: 15,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                    hintText: 'Departure',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.r),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.r),
                        borderSide:
                            BorderSide(color: AppStyles.cardBlueColor))),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.white),
              child: TextField(
                controller: arrival,
                focusNode: arrival_F,
                style:
                    TextStyle(color: AppStyles.cardBlueColor, fontSize: 12.sp),
                cursorColor: AppStyles.cardBlueColor,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 5.h),
                    hintText: 'Arrival',
                    hintStyle: TextStyle(
                        color: arrival_F.hasFocus
                            ? AppStyles.cardBlueColor
                            : Colors.grey),
                    prefixIcon: Icon(
                      Icons.flight_land,
                      color: arrival_F.hasFocus
                          ? AppStyles.cardBlueColor
                          : Colors.grey,
                      size: 15.sp,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(7.r)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppStyles.cardBlueColor),
                        borderRadius: BorderRadius.circular(7.r))),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppStyles.cardBlueColor,
                  borderRadius: BorderRadius.circular(12.r)),
              padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.w),
              child: Center(
                child: Text(
                  'Find Tickets',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Symmetrictext(
                bigText: 'Upcoming Flight', smallText: 'View All', func: () {}),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width * 0.4,
                    height: 420.h,
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.white12),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          height: 190.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Plane_seat.png'),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "20% discount on early booking of this flight. Don't Miss Out.",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width * 0.44,
                          // height: 180.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
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
                                    fontSize: 16.sp,
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
                                      width: 18.w,
                                      color: AppStyles.cardRedColor),
                                  shape: BoxShape.circle),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      width: size.width * 0.44,
                      height: 210.h,
                      padding: EdgeInsets.all(15.r),
                      decoration: BoxDecoration(
                          color: AppStyles.cardRedColor,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Column(
                        children: [
                          Text(
                            'Show Care',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20.h,
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
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
