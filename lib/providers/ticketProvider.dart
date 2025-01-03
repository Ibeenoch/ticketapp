import 'package:airlineticket/AppRoutes.dart';
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
      print('Error fetching ticket $e');
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
      print('Error fetching ticket $e');
    }
  }

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
                    decoration: BoxDecoration(color: Colors.green),
                    child: const Text(
                      'Flight created successfully!',
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
      required String ticketId,
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
          'ticket details are: $pilot $passport $ticketNo $bookingNo $paymentMethod $price $departure_country $arrival_country $flight_duration_hrs $flight_duration_minutes $flight_month $flight_day $userId $ticketId $departure_time_hrs $departure_time_minutes that is all');

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
        print('show the result');
        if (response.success) {
          print('show result');
          int indexTicket =
              _tickets.indexWhere((ticket) => ticket.objectId == ticketId);
          print('the nested ticket: ${indexTicket}');
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
      print('error is creating ticket $e');
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
      print('got the user id to delete is: $ticketUserId');
      final ParseObject ticket = ParseObject('tickets')..objectId = ticketId;

      final ParseResponse response = await ticket.delete();

      if (response.success) {
        _tickets.removeWhere((t) => t.objectId == ticketId);
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ticket successfully deleted')));
        Navigator.pushNamed(context, AppRoutes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Ticket failed to deleted')));
        print(
            'error deleting ticket ${response.error?.message}  ${response.error?.exception}');
      }
    } catch (e) {
      print('Error delete ticket: $e');
    }
  }

  Future<void> searchTicket(String word) async {
    if (word.isEmpty) {
      print('Search term is empty. Aborting search.');
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
        print('Found ticket results: ${response.results}');
        _tickets = response.results as List<ParseObject>;
        notifyListeners();
      } else {
        print('No tickets found. Response: ${response.error?.message}');
        _tickets = [];
        notifyListeners();
      }
    } catch (e, stack) {
      print('Error finding ticket: $e');
      print(stack);
    }
  }
}
