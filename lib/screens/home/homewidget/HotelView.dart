import 'package:flutter/material.dart';
import 'package:powerapp/base/reuseables/styles/App_styles.dart';
import 'package:powerapp/base/reuseables/widgets/cardTitle.dart';
import 'package:powerapp/screens/home/homewidget/hotelText.dart';

class Hotelview extends StatelessWidget {
  final Map<String, dynamic> hotelItem;
  const Hotelview({super.key, required this.hotelItem});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        width: size.width * 0.6,
        height: 300,
        decoration: BoxDecoration(
            color: AppStyles.cardBlueColor,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180,
                width: size.width * 0.6,
                decoration: BoxDecoration(
                  color: AppStyles.cardBlueColor,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage('assets/images/${hotelItem['image']}'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Hoteltext(
              text: hotelItem['name'],
              color: AppStyles.kaki,
            ),
            const SizedBox(
              height: 5,
            ),
            Hoteltext(
              text: hotelItem['location'],
              sizeType: 'h3',
            ),
            const SizedBox(
              height: 5,
            ),
            Hoteltext(
              text: '\$${hotelItem['amount'].toString()}/Night',
              color: AppStyles.kaki,
            ),
          ],
        ),
      ),
    );
  }
}
