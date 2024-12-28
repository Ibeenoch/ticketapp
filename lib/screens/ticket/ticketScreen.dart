import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/base/utils/stringFormatter.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/CurrencyText.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/RowText.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Ticketscreen extends StatefulWidget {
  // final List<Map<String, dynamic>> ticket;
  const Ticketscreen({
    super.key,
  });

  @override
  State<Ticketscreen> createState() => _TicketscreenState();
}

class _TicketscreenState extends State<Ticketscreen> {
  // int currentIndex = 0;
  String currentIndex = '';
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      // final ticketProvider =
      //     Provider.of<Ticketprovider>(context, listen: false);
      // //find a default id to load the bottom nav bar if no id was passed
      // final allTickets = ticketProvider.tickets;
      // final oneTicket = allTickets.take(1).first;
      // final one_id_ticket = oneTicket.get("objectId");

      var args = ModalRoute.of(context)!.settings.arguments as Map;
      currentIndex = args["index"];

      print(
          'final one_id_ticket from changedependence is: currentIndex ${currentIndex}, arg ${args?["index"]} or $args');
    }
    super.didChangeDependencies();
  }

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
    ticketProvider.fetchTicketById(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
    //find a default id to load the bottom nav bar if no id was passed
    final allTickets = ticketProvider.tickets;

    final oneTicket = allTickets.take(1).first;
    final one_id_ticket = oneTicket.get("objectId");
    currentIndex = one_id_ticket;

    ParseObject? foundTicket = allTickets.firstWhere(
      (ticket) => ticket.get<String>('objectId') == currentIndex,
      orElse: () {
        throw Exception("Ticket not found");
      },
    );

    final currentTicket = foundTicket.toJson();
    print('current ticket so far: $currentTicket');

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tickets',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
      ),
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Tickettab(leftText: 'Upcoming', rightText: 'Previous'),
                const SizedBox(
                  height: 25,
                ),
                Ticketview(
                  ticket: currentTicket,
                  showColor: false,
                  showHeight: false,
                ),
                const SizedBox(
                  height: 0.2,
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        Rowtext(
                            bigTextLeft:
                                '${currentTicket['pilot'] ?? 'Edward'}',
                            smallTextLeft: 'Pilot',
                            // bigTextRight: '5221 7383 7684',
                            bigTextRight: formatNumber(
                                '${currentTicket['passport'] ?? '5221 7383 7684'}'),
                            smallTextRight: 'Passport'),
                        const SizedBox(
                          height: 15,
                        ),
                        const Applayoutbuilder(
                          randomWidthNum: 7,
                          showColor: false,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Rowtext(
                            bigTextLeft: formatNumber(
                                '${currentTicket['ticketNo'] ?? '2299 5619 0071 0185'}'),
                            smallTextLeft: 'E-Ticket No',
                            bigTextRight:
                                "${currentTicket['bookingNo'] ?? 'BCJYPM'}",
                            smallTextRight: 'Booking No'),
                        const SizedBox(
                          height: 20,
                        ),
                        Currencytext(
                            payment:
                                "${currentTicket['paymentMethod'] ?? '1882'}",
                            price: "${currentTicket['price'] ?? '2346'}"),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )),
                Container(
                  width: size.width * 0.85,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                      border: Border.all(width: 3, color: Colors.white),
                      color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BarcodeWidget(
                        height: 60,
                        data: 'http://ricket.com',
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        drawText: false,
                        barcode: Barcode.code128()),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Ticketview(
                  ticket: currentTicket,
                  showHeight: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
