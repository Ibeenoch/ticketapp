import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:airlineticket/providers/userProvider.dart';
import 'package:airlineticket/screens/account/account.dart';
import 'package:airlineticket/screens/account/profile.dart';
import 'package:airlineticket/screens/home/HomeScreen.dart';
import 'package:airlineticket/screens/search/search.dart';
import 'package:airlineticket/screens/ticket/ticketScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Ticketprovider? ticketProvider;

  int _curindex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        ticketProvider = Provider.of<Ticketprovider>(context, listen: false);
      });
    });
    //
  }

  void getIndex(int index) {
    setState(() {
      _curindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final currentUser = userProvider.currentUser;

    final appScreens = currentUser == null
        ? [
            const Homescreen(),
            const Search(),
            const Ticketscreen(),
            const Account(),
          ]
        : [
            const Homescreen(),
            const Search(),
            const Ticketscreen(),
            const Profile(),
          ];

    // Validate _curindex
    if (_curindex >= appScreens.length) {
      _curindex = 0;
    }

    return Scaffold(
        body: appScreens[_curindex],
        bottomNavigationBar: new Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppStyles.borderBackGroundColor(context),
          ),
          child: BottomNavigationBar(
              // backgroundColor: AppStyles.defaultBackGroundColor(context),
              onTap: getIndex,
              currentIndex: _curindex,
              selectedItemColor: AppStyles.bottomNavIconColor(context),
              unselectedItemColor: Colors.blueGrey,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.airplane_ticket), label: 'Ticket'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ]),
        ));
  }
}
