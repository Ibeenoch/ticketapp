import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/hostel/hostelWidget/arrowBack.dart';
import 'package:airlineticket/screens/hostel/hostelWidget/hotelImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class HostelDetails extends StatefulWidget {
  const HostelDetails({super.key});

  @override
  State<HostelDetails> createState() => _HostelDetailsState();
}

class _HostelDetailsState extends State<HostelDetails> {
  int currentIndex = 0;
  bool isFullDetails = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      setState(() {
        currentIndex = args['index'];
      });
    }
  }

  void handleEditHotel() async {
    // don't worry about the userId, we can get it from the hostel form screen
    Navigator.pushNamed(context, AppRoutes.hostelForm, arguments: {
      'index': currentIndex,
    });
  }

  void handleDeleteHotel() async {
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    final userId = user?.get<String>('objectId');
    final hostelProvider = Provider.of<HostelProvider>(context, listen: false);
    final hostels = hostelProvider.hotels;
    final hostel = hostels[currentIndex];
    final String? hotelId = hostel.get<String>('objectId');
    print('the ids are $userId $hotelId');
    try {
      await hostelProvider.deleteHostel(hotelId!, userId!, context);
    } catch (e) {
      print('unknown error deleting hostel, $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> getHostel = {};
    final hostelProvider = Provider.of<HostelProvider>(context, listen: false);
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    final allHostels = hostelProvider.hotels;

    ParseObject? foundHostel = allHostels[currentIndex];

    getHostel = foundHostel.toJson();

    final String fullDetails = getHostel['details'];
    final String shortDetails = fullDetails.substring(0, 700);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppStyles.defaultBackGroundColor(context),
            expandedHeight: 300,
            pinned: true,
            floating: false,
            leading: ArrowBack(),
            flexibleSpace:
                FlexibleSpaceBar(background: HotelImage(getHostel: getHostel)),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.all(15.w),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFullDetails = !isFullDetails;
                  });
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                        text:
                            isFullDetails == true ? fullDetails : shortDetails,
                        style: TextStyle(fontSize: 11.sp)),
                    TextSpan(
                        text:
                            isFullDetails == true ? ' Show Less' : ' Show More',
                        style: TextStyle(color: Colors.blue, fontSize: 12.sp))
                  ]),
                ),
              ),
            ),
            user == null ? Container() : actionSection(context),
            SizedBox(
              height: 7.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Text(
                'More Images',
                style: TextStyle(
                    color: AppStyles.cardBlueColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Container(
                height: 160.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: getHostel['imageList'].length,
                    itemBuilder: (context, index) {
                      String imageUrl = getHostel['imageList'][index];
                      return Container(
                        child: Image(
                          image: NetworkImage(imageUrl),
                          width: 205,
                          height: 150,
                        ),
                      );
                    }),
              ),
            ),
            SizedBox(
              height: 20.h,
            )
          ])),
        ],
      ),
    );
  }

  Padding actionSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 10.w),
        decoration: BoxDecoration(
          color: AppStyles.borderBackGroundColor(context),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: handleEditHotel,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                child: Icon(
                  Icons.edit,
                  size: 20.sp,
                  color: AppStyles.cardBlueColor,
                ),
              ),
            ),
            InkWell(
              onTap: handleDeleteHotel,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                child: Icon(
                  Icons.delete,
                  size: 20.sp,
                  color: AppStyles.cardRedColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
