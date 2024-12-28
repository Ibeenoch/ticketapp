import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/shimmerPlaceholder.dart';
import 'package:airlineticket/base/reuseables/widgets/symmetricText.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/home/homewidget/AllTicketScreen.dart';
import 'package:airlineticket/screens/home/homewidget/HotelView.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
    final size = MediaQuery.of(context).size;
    String? username = 'Guest';

    final ticketsProvider = Provider.of<Ticketprovider>(context, listen: false);
    final TicketLists = ticketsProvider.tickets;
    print('all tickets fetched from home screen are: $TicketLists');
    final userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoggedIn) {
      username = userProvider.currentUser!.get<String>('fullname');
    }
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
                        'Good Morning,',
                        style: AppStyles.h5(context),
                      ),
                      Text(
                        '$username',
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
                  return const Allticketscreen();
                },
              ))
            },
          ),
          SizedBox(
            height: 20.h,
          ),
          FutureBuilder(
              future: Provider.of<Ticketprovider>(context, listen: false)
                  .fetchTickets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        ShimmerPlaceholder(
                          width: size.width * 0.8,
                          height: 140.toDouble(),
                          borderRadius: 6.toDouble(),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        ShimmerPlaceholder(
                          width: size.width * 0.8,
                          height: 140.toDouble(),
                          borderRadius: 6.toDouble(),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        ShimmerPlaceholder(
                          width: size.width * 0.8,
                          height: 140.toDouble(),
                          borderRadius: 6.toDouble(),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container(
                    height: 100,
                    color: Colors.red[100],
                    child: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  );
                } else {
                  final tickets =
                      Provider.of<Ticketprovider>(context, listen: false);
                  print('loaded this ticket ${tickets.tickets}');
                  final getTickets = tickets.tickets;
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: getTickets
                            .take(3)
                            .map((singleTicket) =>
                                Ticketview(ticket: singleTicket.toJson()))
                            .toList(),
                      ));
                }
              }),
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
