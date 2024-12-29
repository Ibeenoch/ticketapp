import 'package:airlineticket/base/reuseables/resources/dummyJson.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:airlineticket/base/reuseables/widgets/editDeleteBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/base/utils/stringFormatter.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/CurrencyText.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/RowText.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  Ticketprovider? ticketProvider;
  UserProvider? userProvider;
  String? userId;
  List<ParseObject>? allTickets;
  // int currentIndex = 0;
  String currentIndex = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
        allTickets = ticketProvider?.tickets;
        userProvider = Provider.of<UserProvider>(context, listen: false);
        userId = userProvider?.currentUser?.objectId;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      var args = ModalRoute.of(context)!.settings.arguments as Map;
      currentIndex = args["index"];
    }
  }

  @override
  Widget build(BuildContext context) {
    late String getcurrentIndex = '';
    late Map<String, dynamic> getTicket = {};

    //find a default id to load the bottom nav bar if no id was passed
    final oneTicket = allTickets?.take(1).first;

    final one_id_ticket = oneTicket?.get("objectId");
    if (one_id_ticket != null) {
      getcurrentIndex = one_id_ticket;
    }
    currentIndex = currentIndex == '' ? getcurrentIndex : currentIndex;

    // currentIndex =
    //     currentIndex == '' ? (one_id_ticket ?? 'default_id') : currentIndex;

    print('the current index is $currentIndex');

    ParseObject? foundTicket = allTickets?.firstWhere(
      (ticket) => ticket.get<String>('objectId') == currentIndex,
      orElse: () {
        throw Exception("Ticket not found");
      },
    );

    if (foundTicket != null) {
      getTicket = foundTicket.toJson();
    }
    final currentTicket = getTicket;

    final size = MediaQuery.of(context).size;
    if (currentTicket == null) {
      return Scaffold(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        appBar: AppBar(
          backgroundColor: AppStyles.defaultBackGroundColor(context),
        ),
        body: Center(
          child: Text(
            'The ticket has been deleted!',
            style: TextStyle(fontSize: 16.sp),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.defaultBackGroundColor(context),
          title: const Text(
            'Tickets',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          actions: const [
            HomeNavBtn(),
          ],
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
                  SizedBox(
                    height: 20.h,
                  ),
                  userId == null
                      ? Container()
                      : EditDeleteBtn(
                          leftText: 'Edit',
                          rightText: 'Delete',
                          ticketId: currentIndex,
                          userId: userId!,
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Ticketview(
                    ticket: currentTicket,
                    showHeight: true,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(
                      height: 400.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppStyles.cardBlueColor),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
