import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/ColumnText.dart';
import 'package:powerapp/screens/home/homewidget/RoundedDot.dart';
import 'package:powerapp/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:powerapp/base/reuseables/widgets/cardTitle.dart';
import 'package:powerapp/screens/home/homewidget/halfCircular.dart';

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
                          text: ticket["from"]["code"],
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
                                size: 17.sp,
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
                          text: ticket["to"]["code"],
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
                          text: ticket['from']['name'],
                          sizeType: 'h4',
                          showColor: showColor,
                        ),
                        Expanded(child: Container()),
                        Cardtitle(
                          text: ticket['flying_time'],
                          sizeType: 'h4',
                          align: TextAlign.center,
                          showColor: showColor,
                        ),
                        Expanded(child: Container()),
                        Cardtitle(
                          text: ticket['to']['name'],
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
                          bigtext: ticket['date'],
                          smalltext: 'Date',
                          showColor: showColor,
                        ),
                        Expanded(child: Container()),
                        Columntext(
                            bigtext: ticket['depature_time'],
                            smalltext: 'Departure Time',
                            alignBig: TextAlign.center,
                            showColor: showColor),
                        Expanded(child: Container()),
                        Columntext(
                          bigtext: ticket['number'].toString(),
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
