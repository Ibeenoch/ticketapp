import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/symmetricText.dart';
import 'package:airlineticket/screens/home/homewidget/AllTicketScreen.dart';
import 'package:airlineticket/screens/home/homewidget/HotelView.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final search = TextEditingController();
  FocusNode search_F = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        children: [
          SizedBox(
            height: 40.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning',
                        style: AppStyles.h5(context),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text('Wanna Buy Ticket?', style: AppStyles.h3(context))
                    ],
                  ),
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: const DecorationImage(
                            image: AssetImage(AppMedia.logo))),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7.r)),
                child: TextField(
                  controller: search,
                  focusNode: search_F,
                  autofocus: true,
                  cursorColor: AppStyles.cardBlueColor,
                  style: TextStyle(
                      fontSize: 12.sp, color: AppStyles.cardBlueColor),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for Hotel, Ticket',
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppStyles.cardBlueColor,
                      )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Symmetrictext(
            bigText: 'Upcoming Flight',
            smallText: 'View All',
            func: () => {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Allticketscreen();
                },
              ))
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: TicketList.take(3)
                    .map((singleTicket) => Ticketview(ticket: singleTicket))
                    .toList(),
              )),
          SizedBox(
            height: 10.h,
          ),
          Symmetrictext(
            bigText: 'Hotel',
            smallText: 'View All',
            func: () {
              Navigator.pushNamed(context, AppRoutes.allHotels);
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: HotelList.take(3)
                    .map((hotelItem) => Hotelview(hotelItem: hotelItem))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
