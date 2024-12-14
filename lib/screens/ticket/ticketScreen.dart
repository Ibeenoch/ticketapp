import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/resources/dummyJson.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:powerapp/base/reuseables/widgets/ticketTab.dart';
import 'package:powerapp/screens/home/homewidget/ticketView.dart';
import 'package:powerapp/screens/ticket/ticketwidget/CurrencyText.dart';
import 'package:powerapp/screens/ticket/ticketwidget/RowText.dart';

class Ticketscreen extends StatefulWidget {
  // final List<Map<String, dynamic>> ticket;
  const Ticketscreen({
    super.key,
  });

  @override
  State<Ticketscreen> createState() => _TicketscreenState();
}

class _TicketscreenState extends State<Ticketscreen> {
  int currentIndex = 0;
  @override
  void didChangeDependencies() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      currentIndex = args["index"];
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                  ticket: TicketList[currentIndex],
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
                    child: const Column(
                      children: [
                        Rowtext(
                            bigTextLeft: 'Flutterwave',
                            smallTextLeft: 'Passenger',
                            bigTextRight: '5221 7383 7684',
                            smallTextRight: 'Passport'),
                        SizedBox(
                          height: 15,
                        ),
                        Applayoutbuilder(
                          randomWidthNum: 7,
                          showColor: false,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Rowtext(
                            bigTextLeft: '3234 7389 9090',
                            smallTextLeft: 'E-Ticket No',
                            bigTextRight: 'B2SG6G',
                            smallTextRight: 'Booking No'),
                        SizedBox(
                          height: 20,
                        ),
                        Currencytext(),
                        SizedBox(
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
                  ticket: TicketList[currentIndex],
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
