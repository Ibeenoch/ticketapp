import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/ColumnText.dart';
import 'package:airlineticket/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:airlineticket/base/reuseables/widgets/cardTitle.dart';
import 'package:airlineticket/base/utils/getCountryName.dart';
import 'package:airlineticket/screens/home/homewidget/RoundedDot.dart';
import 'package:airlineticket/screens/home/homewidget/halfCircular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ticketview extends StatelessWidget {
  final Map<String, dynamic> ticket;
  final bool showColor;
  final bool showHeight;
  const Ticketview(
      {super.key,
      required this.ticket,
      this.showColor = true,
      this.showHeight = true});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Center(
        child: SizedBox(
          width: size.width * 0.85,
          height: showHeight ? 155 : null,
          //
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // container shrinked because of the column wrapping the children Container
            children: [
              Container(
                height: 75,
                decoration: BoxDecoration(
                    color: showColor ? AppStyles.cardBlueColor : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                        topRight: Radius.circular(12.r))),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Cardtitle(
                            // text: ticket["from"]["code"],
                            text: ticket['departure_country'] ?? 'N/A',
                            sizeType: 'h3',
                            weightType: 'bold',
                            showColor: showColor,
                          ),
                          Expanded(child: Container()),
                          RoundedDot(
                            showColor: showColor,
                          ),
                          Expanded(
                              child: Stack(
                            children: [
                              SizedBox(
                                height: 18.h,
                                child: Applayoutbuilder(
                                  randomWidthNum: 5,
                                  showColor: showColor,
                                ),
                              ),
                              Center(
                                  child: Transform.rotate(
                                angle: 1.57,
                                child: Icon(
                                  Icons.airplanemode_active,
                                  size: 15.sp,
                                  color: showColor
                                      ? Colors.white
                                      : AppStyles.cardBlueColor,
                                ),
                              ))
                            ],
                          )),
                          RoundedDot(showColor: showColor),
                          Expanded(child: Container()),
                          Cardtitle(
                            // text: ticket["to"]["code"],
                            text: ticket['arrival_country'] ?? 'N/A',
                            sizeType: 'h3',
                            weightType: 'bold',
                            align: TextAlign.end,
                            showColor: showColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          Cardtitle(
                            // text: ticket['from']['name'],
                            text: getCountryName(
                                    ticket['departure_country'] ?? '') ??
                                'Departure Country',
                            sizeType: 'h4',
                            showColor: showColor,
                          ),
                          Expanded(child: Container()),
                          Cardtitle(
                            // text: ticket['flying_time'],
                            text:
                                '${ticket['flight_duration_hrs'] ?? 'N/A'}h ${ticket['flight_duration_minutes'] ?? 'N/A'}m',
                            sizeType: 'h4',
                            align: TextAlign.center,
                            showColor: showColor,
                          ),
                          Expanded(child: Container()),
                          Cardtitle(
                            // text: ticket['to']['name'],
                            text: getCountryName(
                                    ticket['arrival_country'] ?? '') ??
                                'Arrival Country',
                            sizeType: 'h4',
                            align: TextAlign.end,
                            showColor: showColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // middle container
              Container(
                height: 20.h,
                decoration: BoxDecoration(
                    color: showColor ? AppStyles.cardRedColor : Colors.white),
                child: Row(
                  children: [
                    const Halfcircular(
                      isLeft: false,
                    ),
                    Expanded(
                        child: Stack(
                      children: [
                        SizedBox(
                          height: 18.h,
                          child: const Applayoutbuilder(
                            randomWidthNum: 7,
                          ),
                        ),
                      ],
                    )),
                    const Halfcircular(
                      isLeft: true,
                    ),
                  ],
                ),
              ),
              //bottom container
              Container(
                decoration: BoxDecoration(
                    color: showColor ? AppStyles.cardRedColor : Colors.white,
                    borderRadius: showHeight
                        ? BorderRadius.only(
                            bottomLeft: Radius.circular(12.r),
                            bottomRight: Radius.circular(12.r))
                        : null),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Columntext(
                            // bigtext: ticket['date'],
                            bigtext:
                                "${ticket['flight_day'] ?? 'N/A'} ${ticket['flight_month'] ?? 'N/A'}",
                            smalltext: 'Date',
                            showColor: showColor,
                            alignSide: 'start',
                          ),
                          Expanded(child: Container()),
                          Columntext(
                              bigtext:
                                  "${ticket['departure_time_hrs'] ?? 'N/A'} : ${ticket['departure_time_minutes'] ?? 'N/A'} ${int.parse(ticket['departure_time_hrs'] ?? '12') >= 12 ? 'PM' : 'AM'}",
                              smalltext: 'Departure Time',
                              alignBig: TextAlign.center,
                              showColor: showColor),
                          Expanded(child: Container()),
                          Columntext(
                            bigtext: ticket['objectId'] ?? 'N/A',
                            smalltext: 'Number',
                            alignsmall: TextAlign.end,
                            showColor: showColor,
                            alignSide: 'end',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


  // bigtext: (ticket['objectId']?.length > 6
  //                               ? ticket['objectId']?.substring(0, 6) + '...'
  //                               : ticket['objectId'] ?? 'N/A'),