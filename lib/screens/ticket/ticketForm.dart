import 'package:airlineticket/base/reuseables/resources/countries.dart';
import 'package:airlineticket/base/reuseables/styles/App_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Ticketform extends StatefulWidget {
  const Ticketform({super.key});

  @override
  State<Ticketform> createState() => _TicketformState();
}

class _TicketformState extends State<Ticketform> {
  String? _selectedCountry;

  final List<Map<String, String>> _countries = abbreviatedCountries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Text(
              'Create Tickets',
              style: TextStyle(
                  color: AppStyles.textWhiteBlack(context),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.h,
            ),

            Text(
              'Country Departing',
              style: TextStyle(
                  color: AppStyles.textWhiteBlack(context),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 30.h,
            ),

            DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'choose country',
                  border: OutlineInputBorder(),
                ),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    child: Text(country['name']!),
                    value: country['code'],
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCountry = newValue;
                  });
                })

            //  {
            //   'from': {
            //     'code': "NYC",
            //     'name': "New York City",
            //   },
            //   'to': {
            //     'code': "LND",
            //     'name': "London",
            //   },
            //   'flying_time': "8h 30m",
            //   'date': "1st May",
            //   'depature_time': "8:00am",
            //   'number': 23,
            // },
          ],
        ),
      ),
    );
  }
}
