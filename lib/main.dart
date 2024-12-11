import 'package:flutter/material.dart';
import 'package:powerapp/AppRoutes.dart';
import 'package:powerapp/BottomBar.dart';
import 'package:powerapp/screens/home/homewidget/AllHotelViews.dart';
import 'package:powerapp/screens/home/homewidget/AllTicketScreen.dart';
import 'package:powerapp/screens/ticket/ticketScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BottomBar(),
      routes: {
        // AppRoutes.homePage: (context) => const BottomBar(),
        AppRoutes.allTickets: (context) => const Allticketscreen(),
        AppRoutes.allHotels: (context) => const Allhotelviews(),
        AppRoutes.ticketScreen: (context) => const Ticketscreen(),
      },
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
    );
  }
}
