// ignore: file_names
import 'package:airlineticket/AppRoutes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:provider/provider.dart';

class Ticketprovider extends ChangeNotifier {
  List<ParseObject> _tickets = [];
  List<ParseObject> get tickets => _tickets;
  ParseObject? _ticket;
  ParseObject? get ticket => _ticket;

  // add tickets to the list and notify listener;
  void addTicket(ParseObject ticket) {
    _tickets.add(ticket);
    notifyListeners();
  }

  Ticketprovider() {
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      final QueryBuilder<ParseObject> queryTickets =
          QueryBuilder<ParseObject>(ParseObject('tickets'));
      final ParseResponse response = await queryTickets.query();
      if (response.success && response.results != null) {
        _tickets = response.result as List<ParseObject>;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching ticket $e');
      }
    }
  }

  Future<void> fetchTicketById(String ticketId) async {
    try {
      final QueryBuilder<ParseObject> queryTicket =
          QueryBuilder<ParseObject>(ParseObject('tickets'))
            ..whereEqualTo('objectId', ticketId);
      final ParseResponse response = await queryTicket.query();
      if (response.success && response.result != null) {
        _ticket = response.result as ParseObject;
        notifyListeners();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching ticket $e');
      }
    }
  }

  Future<void> createTicket(
      // ignore: non_constant_identifier_names
      {required String departure_country,
      // ignore: non_constant_identifier_names
      required String arrival_country,
      // ignore: non_constant_identifier_names
      required String flight_duration_hrs,
      // ignore: non_constant_identifier_names
      required String flight_duration_minutes,
      // ignore: non_constant_identifier_names
      required String flight_month,
      // ignore: non_constant_identifier_names
      required String flight_day,
      // ignore: non_constant_identifier_names
      required String userId,
      // ignore: non_constant_identifier_names
      required String departure_time_hrs,
      // ignore: non_constant_identifier_names
      required String departure_time_minutes,
      // ignore: non_constant_identifier_names
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
          // ignore: use_build_context_synchronously
          Provider.of<Ticketprovider>(context, listen: false)
              .addTicket(response.result as ParseObject);
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    decoration: BoxDecoration(color: Colors.green),
                    child: const Text(
                      'Flight created successfully!',
                    ))),
          );

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, AppRoutes.allTickets);
        } else {
          if (kDebugMode) {
            print('Error saving flight details: ${response.error?.message}');
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text(
            'Please add all required fields',
          )),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('error is creating ticket $e');
      }
    }
  }

  Future<void> updateTicket(
      // ignore: non_constant_identifier_names
      {required String departure_country,
      // ignore: non_constant_identifier_names
      required String arrival_country,
      // ignore: non_constant_identifier_names
      required String flight_duration_hrs,
      // ignore: non_constant_identifier_names
      required String flight_duration_minutes,
      // ignore: non_constant_identifier_names
      required String flight_month,
      // ignore: non_constant_identifier_names
      required String flight_day,
      // ignore: non_constant_identifier_names
      required String ticketId,
      required String userId,
      // ignore: non_constant_identifier_names
      required String departure_time_hrs,
      // ignore: non_constant_identifier_names
      required String departure_time_minutes,
      // ignore: non_constant_identifier_names
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
          int indexTicket =
              _tickets.indexWhere((ticket) => ticket.objectId == ticketId);

          if (indexTicket > -1) {
            _tickets[indexTicket] = ticket;
            notifyListeners();
            Navigator.pushNamed(context, AppRoutes.homePage);
          }
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
      if (kDebugMode) {
        print('error is creating ticket $e');
      }
    }
  }

  Future<void> deleteTicket(
      String ticketId, String userId, BuildContext context) async {
    try {
      final bool? confirmDelete = await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Confirm action',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              content: Text(
                'Are you sure you want to delete this ticket?',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    )),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    )),
              ],
            );
          });

      if (confirmDelete != true) {
        return;
      }

      final getTicket = await ParseObject('tickets').getObject(ticketId);
      String ticketUserId = '';
      if (getTicket.success) {
        final ticketDetails = getTicket.result;
        ticketUserId = ticketDetails.get<String>('userId');
      }
      final ParseObject ticket = ParseObject('tickets')..objectId = ticketId;

      final ParseResponse response = await ticket.delete();

      if (response.success) {
        _tickets.removeWhere((t) => t.objectId == ticketId);
        notifyListeners();

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ticket successfully deleted')));
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, AppRoutes.homePage);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ticket failed to deleted')));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error delete ticket: $e');
      }
    }
  }

  Future<void> searchTicket(String word) async {
    if (word.isEmpty) {
      if (kDebugMode) {
        print('Search term is empty. Aborting search.');
      }
      return;
    }

    try {
      // Partial match (case-sensitive) for string fields
      final partialSearchQueries = [
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('departure_country', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('arrival_country', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('flight_month', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('flight_day', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('pilot', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('passport', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('ticketNo', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('bookingNo', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereContains('paymentMethod', word),
      ];

      // Full match for exact search (including non-string fields like price)
      final fullSearchQueries = [
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereEqualTo('departure_country', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereEqualTo('arrival_country', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereEqualTo(
              'price', double.tryParse(word)), // Parse price as double
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereEqualTo('flight_duration_hrs', word),
        QueryBuilder<ParseObject>(ParseObject('tickets'))
          ..whereEqualTo('flight_duration_minutes', word),
      ];

      // Combine all queries (partial and full matches)
      final combinedQueries = QueryBuilder.or(
        ParseObject('tickets'),
        [...partialSearchQueries, ...fullSearchQueries],
      );

      // Execute the query
      final ParseResponse response = await combinedQueries.query();
      if (response.success && response.results != null) {
        _tickets = response.results as List<ParseObject>;
        notifyListeners();
      } else {
        _tickets = [];
        notifyListeners();
      }
    } catch (e, stack) {
      if (kDebugMode) {
        print('Error finding ticket: $e');
      }
      if (kDebugMode) {
        print(stack);
      }
    }
  }
}
