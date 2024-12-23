import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:flutter/material.dart';

class Allticketscreen extends StatelessWidget {
  const Allticketscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        title: Text(
          'All Tickets',
          style: AppStyles.h4(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: TicketList.map((singleTicket) => GestureDetector(
                onTap: () {
                  var index = TicketList.indexOf(singleTicket);

                  // Navigator.push(context,
                  //     MaterialPageRoute<void>(builder: (BuildContext context) {
                  //   return Ticketscreen(ticket: TicketList);
                  // }));
                  Navigator.pushNamed(context, AppRoutes.ticketScreen,
                      arguments: {'index': index});
                },
                child: Ticketview(ticket: singleTicket))).toList(),
          ),
        ),
      ),
    );
  }
}
