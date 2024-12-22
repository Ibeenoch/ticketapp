// ignore: file_names
import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/screens/home/homewidget/hotelText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Allhotelviews extends StatelessWidget {
  const Allhotelviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        appBar: AppBar(
          backgroundColor: AppStyles.defaultBackGroundColor(context),
          title: Text(
            'All Hotels',
            textAlign: TextAlign.center,
            style: AppStyles.h4(context),
          ),
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.7),
            itemCount: HotelList.length,
            itemBuilder: (context, index) {
              var singleHotel = HotelList[index];
              return HotelGridView(hotelItem: singleHotel);
            })
        // Center(

        // child: SingleChildScrollView(
        //   scrollDirection: Axis.vertical,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children:
        //         HotelList.map((item) => Hotelview(hotelItem: item)).toList(),
        //   ),
        // ),
        // ),
        );
  }
}

class HotelGridView extends StatelessWidget {
  final Map<String, dynamic> hotelItem;
  const HotelGridView({super.key, required this.hotelItem});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Container(
        // width: size.width * 0.6,
        // height: 300.h,
        decoration: BoxDecoration(
            color: AppStyles.cardBlueColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: Container(
                height: 80,
                // width: size.width * 0.6,
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
              sizeType: 'h3',
            ),
            SizedBox(
              height: 5.h,
            ),
            Hoteltext(
              text: '\$${hotelItem['amount'].toString()}/Night',
              color: AppStyles.kaki,
            ),
          ],
        ),
      ),
    );
  }
}
