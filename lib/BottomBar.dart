import 'package:flutter/material.dart';
import 'package:powerapp/screens/home/HomeScreen.dart';
import 'package:powerapp/screens/account/account.dart';
import 'package:powerapp/screens/search/search.dart';
import 'package:powerapp/screens/ticket/ticketScreen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _curindex = 0;

  void getIndex(int index) {
    setState(() {
      _curindex = index;
    });
  }

  final appScreens = [
    const Homescreen(),
    const Search(),
    const Ticketscreen(),
    const Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreens[_curindex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: getIndex,
          currentIndex: _curindex,
          selectedItemColor: Colors.cyan,
          unselectedItemColor: Colors.blueGrey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.airplane_ticket), label: 'Ticket'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_add_outlined), label: 'Account'),
          ]),
    );
  }
}
