// ignore: file_names
import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/screens/home/homewidget/hotelText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Allhotelviews extends StatefulWidget {
  const Allhotelviews({super.key});

  @override
  State<Allhotelviews> createState() => _AllhotelviewsState();
}

class _AllhotelviewsState extends State<Allhotelviews> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Defer the Provider call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HostelProvider>(context, listen: false).fetchHotels();
    });
  }

  @override
  Widget build(BuildContext context) {
    final hostelProvider = Provider.of<HostelProvider>(context);
    final hostelList = hostelProvider.hotels;

    return Scaffold(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        appBar: AppBar(
          backgroundColor: AppStyles.defaultBackGroundColor(context),
          title: Text(
            'Hotels',
            textAlign: TextAlign.center,
            style: AppStyles.h4(context),
          ),
          actions: [
            HomeNavBtn(),
          ],
        ),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
                childAspectRatio: 0.84),
            itemCount: hostelList.length,
            itemBuilder: (context, index) {
              var singleHotel = hostelList[index];
              var _singleHotel = singleHotel.toJson();
              if (_singleHotel.isNotEmpty) {
                return HotelGridView(hotelItem: _singleHotel, index: index);
              } else {
                print('_singleHotel is empty $_singleHotel');
              }
            }));
  }
}

class HotelGridView extends StatelessWidget {
  final int index;
  final Map<String, dynamic> hotelItem;
  const HotelGridView(
      {super.key, required this.hotelItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.hostelDetails,
            arguments: {'index': index});
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
        child: Container(
          decoration: BoxDecoration(
              color: AppStyles.cardBlueColor,
              borderRadius: BorderRadius.circular(12.r)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.w),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppStyles.cardBlueColor,
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                        // imageList
                        image: hotelItem.isEmpty
                            ? AssetImage('assets/images/${hotelItem['image']}')
                            : NetworkImage('${hotelItem['imageList'][0]}'),
                        // AssetImage('assets/images/${hotelItem['image']}'),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Hoteltext(
                text: hotelItem['name']?.length > 14
                    ? hotelItem['name']?.substring(0, 14) + '...'
                    : hotelItem['name'] ?? 'N/A',
                color: AppStyles.kaki,
              ),
              SizedBox(
                height: 5.h,
              ),
              Hoteltext(
                text: hotelItem['location'] ?? 'N/A',
                sizeType: 'h3',
              ),
              SizedBox(
                height: 3.h,
              ),
              Hoteltext(
                text: '\$${hotelItem['price'].toString()}/Night',
                color: AppStyles.kaki,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
