import 'package:flutter/material.dart';
import 'package:powerapp/AppRoutes.dart';
import 'package:powerapp/base/reuseables/media/App_Media.dart';
import 'package:powerapp/base/reuseables/resources/dummyJson.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/screens/home/homewidget/HotelView.dart';
import 'package:powerapp/base/reuseables/widgets/symmetricText.dart';
import 'package:powerapp/screens/home/homewidget/ticketView.dart';
import 'package:powerapp/screens/home/homewidget/AllHotelViews.dart';
import 'package:powerapp/screens/home/homewidget/AllTicketScreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(
            height: 40,
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
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Wanna Buy Ticket?', style: AppStyles.h1(context))
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        image: const DecorationImage(
                            image: AssetImage(AppMedia.logo))),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7)),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: AppStyles.cardBlueColor,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppStyles.cardBlueColor),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
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
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: TicketList.take(3)
                    .map((singleTicket) => Ticketview(ticket: singleTicket))
                    .toList(),
              )),
          const SizedBox(
            height: 10,
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
