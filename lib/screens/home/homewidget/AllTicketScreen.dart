import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class Allticketscreen extends StatefulWidget {
  const Allticketscreen({super.key});

  @override
  State<Allticketscreen> createState() => _AllticketscreenState();
}

class _AllticketscreenState extends State<Allticketscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
    ticketProvider.fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    final ticketsProvider = Provider.of<Ticketprovider>(context, listen: false);
    final ticketLists = ticketsProvider.tickets;

    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      appBar: AppBar(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        title: Text(
          'All Tickets',
          style: AppStyles.h4(context),
        ),
        actions: const [
          HomeNavBtn(),
        ],
      ),
      body: ticketsProvider.tickets.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: ticketLists
                    .map((singleTicket) => GestureDetector(
                        onTap: () {
                          // Convert singleTicket (ParseObject) to Map<String, dynamic> using toJson
                          final indexObj = singleTicket.toJson();
                          final index = indexObj['objectId'];

                          Navigator.pushNamed(context, AppRoutes.ticketScreen,
                              arguments: {'index': index});
                        },
                        // Convert singleTicket (ParseObject) to Map<String, dynamic> using toJson
                        child: Ticketview(ticket: singleTicket.toJson())))
                    .toList(),
              ),
            ),
    );
  }
}
