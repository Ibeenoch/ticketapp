import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/ColumnText.dart';
import 'package:powerapp/screens/home/homewidget/RoundedDot.dart';
import 'package:powerapp/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:powerapp/base/reuseables/widgets/cardTitle.dart';
import 'package:powerapp/screens/home/homewidget/halfCircular.dart';

class Ticketview extends StatelessWidget {
  final Map<String, dynamic> ticket;
  const Ticketview({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: size.width * 0.85,
        height: 179,
        //
        child: Container(
          child: Column(
            // container shrinked because of the column warpping the children Container
            children: [
              Container(
                decoration: BoxDecoration(
                    color: AppStyles.cardBlueColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Cardtitle(
                            text: ticket["from"]["code"],
                            sizeType: 'h3',
                            weightType: 'bold',
                          ),
                          Expanded(child: Container()),
                          const RoundedDot(),
                          Expanded(
                              child: Stack(
                            children: [
                              const SizedBox(
                                height: 18,
                                child: Applayoutbuilder(
                                  randomWidthNum: 7,
                                ),
                              ),
                              Center(
                                  child: Transform.rotate(
                                angle: 1.57,
                                child: const Icon(
                                  Icons.airplanemode_active,
                                  size: 17,
                                  color: Colors.white,
                                ),
                              ))
                            ],
                          )),
                          const RoundedDot(),
                          Expanded(child: Container()),
                          Cardtitle(
                            text: ticket["to"]["code"],
                            sizeType: 'h3',
                            weightType: 'bold',
                            align: TextAlign.end,
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
                          ),
                          Expanded(child: Container()),
                          Cardtitle(
                            text: ticket['flying_time'],
                            sizeType: 'h4',
                            align: TextAlign.center,
                          ),
                          Expanded(child: Container()),
                          Cardtitle(
                            text: ticket['to']['name'],
                            sizeType: 'h4',
                            align: TextAlign.end,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // middle container
              Container(
                height: 20,
                decoration: BoxDecoration(color: AppStyles.cardRedColor),
                child: const Row(
                  children: [
                    Halfcircular(
                      isLeft: false,
                    ),
                    Expanded(
                        child: Stack(
                      children: [
                        SizedBox(
                          height: 18,
                          child: Applayoutbuilder(
                            randomWidthNum: 7,
                          ),
                        ),
                      ],
                    )),
                    Halfcircular(
                      isLeft: true,
                    ),
                  ],
                ),
              ),
              //bottom container
              Container(
                decoration: BoxDecoration(
                    color: AppStyles.cardRedColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Columntext(
                              bigtext: ticket['date'], smalltext: 'Date'),
                          Expanded(child: Container()),
                          Columntext(
                            bigtext: ticket['depature_time'],
                            smalltext: 'Departure Time',
                            align: TextAlign.center,
                          ),
                          Expanded(child: Container()),
                          Columntext(
                            bigtext: ticket['number'].toString(),
                            smalltext: 'Number',
                            align: TextAlign.end,
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
