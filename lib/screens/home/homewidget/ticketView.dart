import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/ColumnText.dart';
import 'package:airlineticket/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:airlineticket/base/reuseables/widgets/cardTitle.dart';
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
    //  String departureCode = ticket['departure_country'];

    String? getCountryName(String code) {
      final country = abbreviatedCountries.firstWhere(
        (country) => country['code'] == code,
        orElse: () => <String, String>{},
      );
      return country?['name'];
    }

    print('preveiw ticket $ticket');
    // extract the data from the Lists of ticket
    //             String departureCountry = singleTicket.get<String>('departure_country') ?? '';
    //             String arrivalCountry = singleTicket.get<String>('arrival_country') ?? '';
    // String flightDurationHours = singleTicket.get<String>('flight_duration_hrs') ?? '';
    // String flightDurationMinutes = singleTicket.get<String>('flight_duration_minutes') ?? '';
    // String flightMonth = singleTicket.get<String>('flight_month') ?? '';
    // String flightDay = singleTicket.get<String>('flight_day') ?? '';
    // String departureTimeHours = singleTicket.get<String>('departure_time_hrs') ?? '';
    // String departureTimeMinutes = singleTicket.get<String>('departure_time_minutes') ?? '';

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: SizedBox(
        width: size.width * 0.85,
        height: showHeight ? 150 : null,
        //
        child: Column(
          // container shrinked because of the column wrapping the children Container
          children: [
            Container(
              decoration: BoxDecoration(
                  color: showColor ? AppStyles.cardBlueColor : Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      topRight: Radius.circular(12.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Cardtitle(
                          // text: ticket["from"]["code"],
                          text: ticket['departure_country'] ?? '',
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
                          text: ticket['arrival_country'],
                          sizeType: 'h3',
                          weightType: 'bold',
                          align: TextAlign.end,
                          showColor: showColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
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
                              '${ticket['flight_duration_hrs'] ?? ''}h ${ticket['flight_duration_minutes'] ?? ''}m',
                          sizeType: 'h4',
                          align: TextAlign.center,
                          showColor: showColor,
                        ),
                        Expanded(child: Container()),
                        Cardtitle(
                          // text: ticket['to']['name'],
                          text:
                              getCountryName(ticket['arrival_country'] ?? '') ??
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Columntext(
                          // bigtext: ticket['date'],
                          bigtext:
                              "${ticket['flight_day' ?? '']} ${ticket['flight_month'] ?? ''}",
                          smalltext: 'Date',
                          showColor: showColor,
                        ),
                        Expanded(child: Container()),
                        Columntext(
                            bigtext:
                                "${ticket['departure_time_hrs'] ?? ''} ${ticket['departure_time_minutes'] ?? ''}",
                            smalltext: 'Departure Time',
                            alignBig: TextAlign.center,
                            showColor: showColor),
                        Expanded(child: Container()),
                        Columntext(
                          bigtext: ticket['objectId'] ?? '',
                          smalltext: 'Number',
                          alignsmall: TextAlign.end,
                          showColor: showColor,
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
    );
  }
}
