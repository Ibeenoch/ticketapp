import 'dart:math';

import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/base/reuseables/widgets/appLayoutBuilder.dart';
import 'package:airlineticket/base/reuseables/widgets/editDeleteBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/homeNavBtn.dart';
import 'package:airlineticket/base/reuseables/widgets/ticketTab.dart';
import 'package:airlineticket/base/utils/getCountryName.dart';
import 'package:airlineticket/base/utils/stringFormatter.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/home/homewidget/ticketView.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/CurrencyText.dart';
import 'package:airlineticket/screens/ticket/ticketwidget/RowText.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';

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
  late LatLng getInitialCoordinate = LatLng(51.509364, -0.128928);

  String currentIndex = '';
  final MapController _mapController = MapController();

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

      // fitBounds(curvedRoute);
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

    ParseObject? foundTicket = allTickets?.firstWhere(
      (ticket) => ticket.get<String>('objectId') == currentIndex,
      orElse: () {
        throw Exception("Ticket not found");
      },
    );

    if (foundTicket != null) {
      getTicket = foundTicket.toJson();
    }
    print('ticket found is $foundTicket');
    final currentTicket = getTicket;

    final departureCountry =
        getCountryName(currentTicket['departure_country'] ?? '');
    final arrivalCountry =
        getCountryName(currentTicket['arrival_country'] ?? '');

    final departureCountryCoordinate = countriesCoordinates.firstWhere(
      (country) => country['country'] == departureCountry,
      orElse: () => {
        'latitude': 51.509364, // Default latitude
        'longitude':
            -0.128928, // Default longitude LatLng(51.509364, -0.128928);
      },
    );

    final arrivalCountryCoordinate = countriesCoordinates.firstWhere(
      (country) => country['country'] == arrivalCountry,
      orElse: () => {
        'latitude': 51.509364, // Default latitude
        'longitude': -0.128928, // Default longitude
      },
    );

    // var canada = countriesCoordinates.firstWhere(
    //   (country) => country['country'] == 'Canada',
    // );
    // print(
    //     'Canada Coordinates: Latitude: ${canada['latitude']}, Longitude: ${canada['longitude']} $currentTicket');

    // defined departure and arrival and coordinate
    // final LatLng departure = LatLng(51.5074, -0.1278); // London (UK)
    final LatLng departure = LatLng(departureCountryCoordinate['latitude'],
        departureCountryCoordinate['longitude']); // London (UK)
    final LatLng arrival = LatLng(arrivalCountryCoordinate['latitude'],
        arrivalCountryCoordinate['longitude']); // New York (USA)
    setState(() {
      getInitialCoordinate = departure;
    });
    print(' the new coord is $getInitialCoordinate');

    // Function to generate a slightly curved route between the start and end points
    List<LatLng> generateCurvedRoute(LatLng start, LatLng end) {
      List<LatLng> route = [start];

      // Number of intermediate points (more points = smoother curve)
      int numPoints = 30;
      double deltaLat = (end.latitude - start.latitude) / numPoints;
      double deltaLon = (end.longitude - start.longitude) / numPoints;

      // Generate intermediate points that form a curved path
      for (int i = 1; i < numPoints; i++) {
        double lat = start.latitude + deltaLat * i;
        double lon = start.longitude + deltaLon * i;

        // Introduce a small sine wave to create the curve effect
        double curveFactor =
            sin(i / numPoints * pi) * 0.5; // Adjust the curve strength
        lat += curveFactor * 0.5; // Adjust latitude for the curve
        lon += curveFactor * 0.5; // Adjust longitude for the curve

        route.add(LatLng(lat, lon));
      }

      route.add(end); // End point
      return route;
    }

    // Generate random intermediate points to create a haphazard path
    List<LatLng> curvedRoute = generateCurvedRoute(departure, arrival);

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
                  Tickettab(
                    leftText: 'Upcoming',
                    rightText: 'Previous',
                    leftFunc: () {},
                    rightFunc: () {},
                  ),
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
                      height: 650.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: AppStyles.cardBlueColor),
                      child: Stack(children: [
                        FlutterMap(
                          options: MapOptions(
                            initialCenter:
                                getInitialCoordinate, // Center the map over London
                            initialZoom: 5.2,
                          ),
                          children: [
                            TileLayer(
                              // Display map tiles from any source
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                              userAgentPackageName: 'com.example.airticket',
                              // And many more recommended properties!
                            ),
                            // Polyline Layer: Draw the haphazard route
                            // PolylineLayer(
                            //   polylines: [
                            //     Polyline(
                            //       points: haphazardRoute,
                            //       strokeWidth: 4.0,
                            //       color: Colors.blue,
                            //     ),
                            //   ],
                            // ),

                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: curvedRoute,
                                  strokeWidth: 4.0,
                                  color: AppStyles
                                      .cardBlueColor, // Using your custom color
                                ),
                              ],
                            ),

                            RichAttributionWidget(
                              // Include a stylish prebuilt attribution widget that meets all requirments
                              attributions: [
                                TextSourceAttribution(
                                  'OpenStreetMap contributors',
                                  // onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')), // (external)
                                ),
                                // Also add images...
                              ],
                            ),
                          ],
                        )
                      ]),
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
