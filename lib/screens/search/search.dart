import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/symmetricText.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/screens/search/searchWidget/EmojiContainer.dart';
import 'package:airlineticket/screens/search/searchWidget/leftCard.dart';
import 'package:airlineticket/screens/search/searchWidget/rightDownCard.dart';
import 'package:airlineticket/screens/search/searchWidget/rightUpCard.dart';
import 'package:airlineticket/screens/search/searchWidget/searchBtn.dart';
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
  bool isSearchFocus = false;

  final arrival = TextEditingController();
  FocusNode arrival_F = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    departure_F.addListener(() {
      if (departure_F.hasFocus) {
        setState(() {
          isSearchFocus = true;
          handleSearchInputFocus();
        });
      }
    });

    arrival_F.addListener(() {
      if (arrival_F.hasFocus) {
        setState(() {
          isSearchFocus = true;
          handleSearchInputFocus();
        });
      }
    });
  }

  void handleSearchInputFocus() {
    if (isSearchFocus == true) {
      Navigator.pushNamed(context, AppRoutes.searchInput,
          arguments: {'source': 'search'});
      setState(() {
        isSearchFocus = false;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose

    departure.dispose();
    arrival.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        actions: [
          HomeNavBtn(),
        ],
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.homePage);
            },
            child: Icon(Icons.arrow_back)),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
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
              child: Tickettab(
                leftText: 'Tickets',
                rightText: 'Hotels',
                leftFunc: () {},
                rightFunc: () {},
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            searchInput(
                departure, departure_F, Icons.flight_takeoff, 'Departure'),
            SizedBox(
              height: 25.h,
            ),
            searchInput(arrival, arrival_F, Icons.flight_land, 'Arrival'),
            SizedBox(
              height: 25.h,
            ),
            SearchBtn(),
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
                LeftCard(),
                Column(
                  children: [
                    RightUpCard(),
                    SizedBox(
                      height: 20.h,
                    ),
                    RightDownCard(),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget searchInput(TextEditingController controller, FocusNode focus,
      IconData icon, String text) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r), color: Colors.white),
      child: TextField(
        controller: controller,
        // focusNode: arrival_F,
        focusNode: focus,
        style: TextStyle(color: AppStyles.cardBlueColor, fontSize: 12.sp),
        cursorColor: AppStyles.cardBlueColor,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 5.h),
            hintText: text,
            hintStyle: TextStyle(
                color: focus.hasFocus ? AppStyles.cardBlueColor : Colors.grey),
            prefixIcon: Icon(
              icon,
              color: focus.hasFocus ? AppStyles.cardBlueColor : Colors.grey,
              size: 15.sp,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(7.r)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStyles.cardBlueColor),
                borderRadius: BorderRadius.circular(7.r))),
      ),
    );
  }
}
