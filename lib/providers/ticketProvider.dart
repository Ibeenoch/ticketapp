import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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

  Future<void> fetchTickets() async {
    try {
      final QueryBuilder<ParseObject> queryTickets =
          QueryBuilder<ParseObject>(ParseObject('tickets'));
      final ParseResponse response = await queryTickets.query();
      if (response.success && response.results != null) {
        _tickets = response.result as List<ParseObject>;
        print(
            'fetched al tickets: ${_ticket}, ${response.result} and  ${response.results}');
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
}
