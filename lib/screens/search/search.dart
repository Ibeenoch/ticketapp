import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/symmetricText.dart';
import 'package:powerapp/base/reuseables/widgets/ticketTab.dart';
import 'package:powerapp/screens/search/searchWidget/ArrivalType.dart';
import 'package:powerapp/screens/search/searchWidget/EmojiContainer.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppStyles.defaultBackGroundColor(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Text(
              'What Are\nYou Looking For?',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.textWhiteBlack(context)),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child:
                  const Tickettab(leftText: 'All Tickets', rightText: 'Hotels'),
            ),
            const SizedBox(
              height: 25,
            ),
            const Arrivaltype(
              text: 'Departure',
              icon: Icons.flight_takeoff,
            ),
            const SizedBox(
              height: 25,
            ),
            const Arrivaltype(
              text: 'Arrival',
              icon: Icons.flight_land,
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                  color: AppStyles.cardBlueColor,
                  borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: const Center(
                child: Text(
                  'Find Tickets',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Symmetrictext(
                bigText: 'Upcoming Flight', smallText: 'View All', func: () {}),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: size.width * 0.44,
                    height: 435,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              color: Colors.white12),
                        ]),
                    child: Column(
                      children: [
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Plane_seat.png'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "20% discount on early booking of this flight. Don't Miss Out.",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: size.width * 0.44,
                          height: 180,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppStyles.cardBlueColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Discount For\nTicket Survey',
                                style: AppStyles.h3White(context),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              const Text(
                                'Take a short survey about our service  and get a discount',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: -45,
                            right: -50,
                            child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 18, color: AppStyles.cardRedColor),
                                  shape: BoxShape.circle),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width * 0.44,
                      height: 210,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: AppStyles.cardRedColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Column(
                        children: [
                          Text(
                            'Show Care',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Emojicontainer(text: '🥰'),
                                Emojicontainer(text: '😍'),
                                Emojicontainer(text: '🤗'),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
