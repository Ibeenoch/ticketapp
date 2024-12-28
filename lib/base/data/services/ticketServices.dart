import 'dart:math';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/reuseables/widgets/dialog.dart';
import 'package:airlineticket/providers/ticketProvider.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class TicketServices {
  Future<void> createTicket(
      {required String departure_country,
      required String arrival_country,
      required String flight_duration_hrs,
      required String flight_duration_minutes,
      required String flight_month,
      required String flight_day,
      required String userId,
      required String departure_time_hrs,
      required String departure_time_minutes,
      required String pilot,
      required String passport,
      required String ticketNo,
      required String bookingNo,
      required String paymentMethod,
      required String price,
      required BuildContext context}) async {
    try {
      print(
          'ticket details are: $pilot $passport $ticketNo $bookingNo $paymentMethod $price ');
      if (departure_country.isNotEmpty &&
          arrival_country.isNotEmpty &&
          flight_duration_hrs.isNotEmpty &&
          flight_duration_minutes.isNotEmpty &&
          flight_month.isNotEmpty &&
          flight_day.isNotEmpty &&
          userId.isNotEmpty &&
          departure_time_hrs.isNotEmpty &&
          departure_time_minutes.isNotEmpty &&
          pilot.isNotEmpty &&
          passport.isNotEmpty &&
          ticketNo.isNotEmpty &&
          bookingNo.isNotEmpty &&
          paymentMethod.isNotEmpty &&
          price.isNotEmpty) {
        final ticketDetails = ParseObject('tickets')
          ..set('departure_country', departure_country)
          ..set('arrival_country', arrival_country)
          ..set('flight_duration_hrs', flight_duration_hrs)
          ..set('flight_duration_minutes', flight_duration_minutes)
          ..set('flight_month', flight_month)
          ..set('flight_day', flight_day)
          ..set('userId', userId)
          ..set('departure_time_hrs', departure_time_hrs)
          ..set('departure_time_minutes', departure_time_minutes)
          ..set('pilot', pilot)
          ..set('passport', passport)
          ..set('ticketNo', ticketNo)
          ..set('bookingNo', bookingNo)
          ..set('paymentMethod', paymentMethod)
          ..set('price', price);

        final ParseResponse response = await ticketDetails.save();

        if (response.success) {
          Provider.of<Ticketprovider>(context, listen: false)
              .addTicket(response.result as ParseObject);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    color: Colors.red,
                    child: const Text(
                      'Flight details saved successfully!',
                    ))),
          );
          print('ticket result saved is ${response.result}');

          Navigator.pushNamed(context, AppRoutes.allTickets);
        } else {
          print('Error saving flight details: ${response.error?.message}');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Container(
                  color: Colors.red,
                  child: const Text(
                    'Please add all required fields',
                  ))),
        );
      }
    } catch (e) {
      print('error is creating ticket $e');
    }
  }

  Future<void> updateTicket(
      {required String departure_country,
      required String arrival_country,
      required String flight_duration_hrs,
      required String flight_duration_minutes,
      required String flight_month,
      required String flight_day,
      required String userId,
      required String ticketId,
      required String departure_time_hrs,
      required String departure_time_minutes,
      required String pilot,
      required String passport,
      required String ticketNo,
      required String bookingNo,
      required String paymentMethod,
      required String price,
      required BuildContext context}) async {
    try {
      if (departure_country.isNotEmpty &&
          arrival_country.isNotEmpty &&
          flight_duration_hrs.isNotEmpty &&
          flight_duration_minutes.isNotEmpty &&
          flight_month.isNotEmpty &&
          flight_day.isNotEmpty &&
          userId.isNotEmpty &&
          ticketId.isNotEmpty &&
          departure_time_hrs.isNotEmpty &&
          departure_time_minutes.isNotEmpty &&
          pilot.isNotEmpty &&
          passport.isNotEmpty &&
          ticketNo.isNotEmpty &&
          bookingNo.isNotEmpty &&
          paymentMethod.isNotEmpty &&
          price.isNotEmpty) {
        var ticket = ParseObject('tickets')
          ..objectId = ticketId
          ..set('departure_country', departure_country)
          ..set('arrival_country', arrival_country)
          ..set('flight_duration_hrs', flight_duration_hrs)
          ..set('flight_duration_minutes', flight_duration_minutes)
          ..set('flight_month', flight_month)
          ..set('flight_day', flight_day)
          ..set('departure_time_hrs', departure_time_hrs)
          ..set('departure_time_minutes', departure_time_minutes)
          ..set('pilot', pilot)
          ..set('passport', passport)
          ..set('ticketNo', ticketNo)
          ..set('bookingNo', bookingNo)
          ..set('paymentMethod', paymentMethod)
          ..set('price', price);

        var response = await ticket.save();

        if (response.success) {
          print('editing ticket: ${response.result}');
          Navigator.pushNamed(
            context,
            AppRoutes.homePage,
          );
        }

        // final query = QueryBuilder<ParseObject>(ParseObject('tickets'))
        //   ..whereEqualTo('objectId', ticketId);

        // final ParseResponse response = await query.query();

        // if (response.success &&
        //     response.results != null &&
        //     response.results!.isNotEmpty) {
        //   final ticket = response.results!.first as ParseObject;
        //   final String? ticketuserId = ticket.get<String>('userId');

        //   if (ticketuserId == null) {
        //     dialogBuilder(context, 'Ticket owner not found');
        //     return;
        //   } else {
        //     if (userId != ticketuserId) {
        //       dialogBuilder(
        //           context, 'You are not authorized to Update this Ticket!');
        //       return;
        //     } else {
        //       ticket
        //         ..set('departure_country', departure_country)
        //         ..set('arrival_country', arrival_country)
        //         ..set('flight_duration_hrs', flight_duration_hrs)
        //         ..set('flight_duration_minutes', flight_duration_minutes)
        //         ..set('flight_month', flight_month)
        //         ..set('flight_day', flight_day)
        //         ..set('departure_time_hrs', departure_time_hrs)
        //         ..set('departure_time_minutes', departure_time_minutes)
        //         ..set('pilot', pilot)
        //         ..set('passport', passport)
        //         ..set('ticketNo', ticketNo)
        //         ..set('bookingNo', bookingNo)
        //         ..set('paymentMethod', paymentMethod)
        //         ..set('price', price);

        //       final ParseResponse saveResponse = await ticket.save();

        //       if (saveResponse.success) {
        //         Provider.of<Ticketprovider>(context, listen: false)
        //             .addTicket(saveResponse.result as ParseObject);
        //         ScaffoldMessenger.of(context).showSnackBar(
        //           SnackBar(
        //               content: Container(
        //                   color: Colors.red,
        //                   child: const Text(
        //                     'Flight details updated successfully!',
        //                   ))),
        //         );
        //         print('ticket result saved is ${saveResponse.result}');

        //         Navigator.pushNamed(context, AppRoutes.homePage);
        //       }
        //     }
        //   }
        // } else {
        //   print('Error saving flight details: ${response.error?.message}');
        // }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Container(
                  color: Colors.red,
                  child: const Text(
                    'Please add all required fields',
                  ))),
        );
      }
    } catch (e) {
      print('error is creating ticket $e');
    }
  }
}

                //   'from': { departure_country arrival_country flight_duration_hrs flight_duration_minutes 
                //flight_month flight_day userId departure_time_hrs  departure_time_minutes
