import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/ticketTab.dart';

class Ticketscreen extends StatelessWidget {
  const Ticketscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: ListView(
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tickets',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Tickettab(leftText: 'Upcoming', rightText: 'Previous')
              ],
            ),
          )
        ],
      ),
    );
  }
}
