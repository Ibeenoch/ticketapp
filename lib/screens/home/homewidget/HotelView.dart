import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/screens/home/homewidget/hotelText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Hotelview extends StatefulWidget {
  final Map<String, dynamic> hotelItem;
  const Hotelview({super.key, required this.hotelItem});

  @override
  State<Hotelview> createState() => _HotelviewState();
}

class _HotelviewState extends State<Hotelview> {
  @override
  Widget build(BuildContext context) {
    final allHostels =
        Provider.of<HostelProvider>(context, listen: false).hotels;
    final hostel = widget.hotelItem;
    final hostelId = hostel['objectId'];

    int? index = allHostels.indexWhere(
      (hostel) => hostel.get('objectId') == hostelId,
    );

    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.hostelDetails,
            arguments: {'index': index});
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
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
                        image:
                            NetworkImage("${widget.hotelItem['imageList'][0]}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Hoteltext(
                text: widget.hotelItem['name'],
                color: AppStyles.kaki,
              ),
              SizedBox(
                height: 5.h,
              ),
              Hoteltext(
                text: widget.hotelItem['location'],
                sizeType: 'h4',
                weightType: 'normal',
              ),
              SizedBox(
                height: 5.h,
              ),
              Hoteltext(
                text: '\$${widget.hotelItem['price'].toString()}/Night',
                color: AppStyles.kaki,
                sizeType: 'h4',
                weightType: 'normal',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
