import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/media/App_Media.dart';
import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/shimmerPlaceholder.dart';
import 'package:airlineticket/base/reuseables/widgets/symmetricText.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/home/homewidget/AllTicketScreen.dart';
import 'package:airlineticket/screens/home/homewidget/AssetProfilePics.dart';
import 'package:airlineticket/screens/home/homewidget/HotelView.dart';
import 'package:airlineticket/screens/home/homewidget/headerText.dart';
import 'package:airlineticket/screens/home/homewidget/networkProfilePics.dart';
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
  Ticketprovider? ticketProvider;
  UserProvider? userProvider;
  bool? isLoggedIn;
  bool isFocus = false;

  final search = TextEditingController();
  FocusNode search_F = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
        userProvider = Provider.of<UserProvider>(context, listen: false);
        isLoggedIn = userProvider?.isLoggedIn;
      });
    });

    search_F.addListener(() {
      if (search_F.hasFocus) {
        // Unfocus the TextField

        setState(() {
          isFocus = true;
          handleFocus();
        });
      }
    });
  }

  void handleFocus() {
    if (isFocus) {
      Navigator.pushNamed(context, AppRoutes.searchInput,
          arguments: {'source': 'Home'});
      setState(() {
        isFocus = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String? username = 'Guest';
    String? profileImg = 'Guest';

    // final user = context.watch<UserProvider>().currentUser;

    if (isLoggedIn == true) {
      username = userProvider?.currentUser?.get<String>('fullname');
      profileImg = userProvider?.currentUser?.get<String>('profile_img');
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
                  HeaderText(username: username!),
                  profileImg == 'Guest'
                      ? AssetProfilePics()
                      : NetworkProfilePics(profileImg: profileImg!)
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              searchInput(),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Symmetrictext(
            bigText: 'Upcoming Flight',
            smallText: 'View All',
            func: () => {Navigator.pushNamed(context, AppRoutes.allTickets)},
          ),
          SizedBox(
            height: 20.h,
          ),
          ticketPackage(context, size),
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
          hotelPackage(context, size),
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  FutureBuilder<void> hotelPackage(BuildContext context, Size size) {
    return FutureBuilder(
        future:
            Provider.of<HostelProvider>(context, listen: false).fetchHotels(),
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
                    width: size.width * 0.6,
                    height: 300.toDouble(),
                    borderRadius: 8.toDouble(),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ShimmerPlaceholder(
                    width: size.width * 0.6,
                    height: 300.toDouble(),
                    borderRadius: 8.toDouble(),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  ShimmerPlaceholder(
                    width: size.width * 0.6,
                    height: 300.toDouble(),
                    borderRadius: 8.toDouble(),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: 200,
              color: Colors.red[100],
              child: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else {
            final hostels =
                Provider.of<HostelProvider>(context, listen: false).hotels;
            return Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: hostels
                      .take(3)
                      .map((hotelItem) => Hotelview(
                            hotelItem: hotelItem.toJson(),
                          ))
                      .toList(),
                ),
              ),
            );
          }
        });
  }

  FutureBuilder<void> ticketPackage(BuildContext context, Size size) {
    return FutureBuilder(
        future:
            Provider.of<Ticketprovider>(context, listen: false).fetchTickets(),
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
            final tickets = Provider.of<Ticketprovider>(context, listen: false);
            final getTickets = tickets.tickets;
            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: getTickets
                      .take(3)
                      .map((singleTicket) => GestureDetector(
                          onTap: () {
                            final indexObj = singleTicket.toJson();
                            final index = indexObj['objectId'];
                            Navigator.pushNamed(context, AppRoutes.ticketScreen,
                                arguments: {'index': index});
                          },
                          child: Ticketview(ticket: singleTicket.toJson())))
                      .toList(),
                ));
          }
        });
  }

  Container searchInput() {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(7.r)),
      child: TextField(
        controller: search,
        focusNode: search_F,
        cursorColor: AppStyles.cardBlueColor,
        style: TextStyle(fontSize: 10.sp, color: AppStyles.cardBlueColor),
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search for Hotel, Ticket',
            prefixIcon: Icon(
              Icons.search,
              color: AppStyles.cardBlueColor,
              size: 14.sp,
            )),
      ),
    );
  }
}
