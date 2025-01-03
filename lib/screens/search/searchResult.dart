import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/providers/hostelProvider.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/screens/home/homewidget/HotelView.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String searchWord = '';
  List<Map<String, dynamic>> matchingTicketWordsArr = [];
  List<Map<String, dynamic>> matchingHotelsWordsArr = [];
  bool isTicket = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final search = args['search'];
    searchWord = search;

    // Perform initial search on dependencies change
    searchTicket(searchWord);
    searchHotels(searchWord);
  }

  Future<void> searchTicket(String search) async {
    final ticketProvider = Provider.of<Ticketprovider>(context, listen: false);

    try {
      await ticketProvider.searchTicket(search);

      final ticketsFound = ticketProvider.tickets;
      print('search ticket');
      setState(() {
        isTicket = true;
        matchingTicketWordsArr =
            ticketsFound.map((ticket) => ticket.toJson()).toList();
      });
    } catch (e) {
      print('error finding search Ticket');
    }
  }

  Future<void> searchHotels(String search) async {
    final hotelProvider = Provider.of<HostelProvider>(context, listen: false);

    try {
      await hotelProvider.searchHotel(search);
      print('search hotels');
      final hotelsFound = hotelProvider.hotels;
      setState(() {
        isTicket = false;
        matchingHotelsWordsArr =
            hotelsFound.map((hotel) => hotel.toJson()).toList();
      });
    } catch (e) {
      print('error finding search Hotel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyles.defaultBackGroundColor(context),
        appBar: AppBar(
          backgroundColor: AppStyles.defaultBackGroundColor(context),
          title: Text(
            'Search Results',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          actions: [
            HomeNavBtn(),
          ],
        ),
        body: Column(
          children: [
            Tickettab(
              leftText: 'Ticket',
              rightText: 'Hotel',
              leftFunc: () {
                if (searchWord.isNotEmpty) {
                  searchTicket(searchWord);
                }
              },
              rightFunc: () {
                if (searchWord.isNotEmpty) {
                  searchHotels(searchWord); // Trigger hotel search
                }
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: isTicket
                  ? matchingTicketWordsArr.isEmpty
                      ? Center(
                          child: Text(
                            'No Ticket Found',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : ListView(
                          children: matchingTicketWordsArr
                              .map((singleTicket) => GestureDetector(
                                  onTap: () {
                                    final indexObj = singleTicket;
                                    final index = indexObj['objectId'];

                                    Navigator.pushNamed(
                                        context, AppRoutes.ticketScreen,
                                        arguments: {'index': index});
                                  },
                                  child: Ticketview(ticket: singleTicket)))
                              .toList(),
                        )
                  : matchingHotelsWordsArr.isEmpty
                      ? Center(
                          child: Text(
                            'No Hotels Found',
                            style: TextStyle(
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: matchingHotelsWordsArr
                                .map((hotelItem) => Hotelview(
                                      hotelItem: hotelItem,
                                    ))
                                .toList(),
                          ),
                        ),
            ),
            SizedBox(
              height: 20.h,
            )
          ],
        ));
  }
}
