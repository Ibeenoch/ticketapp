import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/resources/dummyJson.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/screens/home/homewidget/HotelView.dart';

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
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                HotelList.map((item) => Hotelview(hotelItem: item)).toList(),
          ),
        ),
      ),
    );
  }
}
