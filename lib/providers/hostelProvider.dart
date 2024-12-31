import 'dart:io';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/services/multipleImageUpload.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

class HostelProvider extends ChangeNotifier {
  List<ParseObject> _hotels = [];
  List<ParseObject> get hotels => _hotels;

  ParseObject? _hotel;
  ParseObject? get hotel => _hotel;

  // add hotels to the list
  void addTicket(ParseObject hotel) {
    _hotels.add(hotel);
    notifyListeners();
  }

  HostelProvider() {
    fetchHotels();
  }

  Future<void> fetchHotels() async {
    try {
      final QueryBuilder<ParseObject> queryHostels =
          QueryBuilder<ParseObject>(ParseObject('hotels'));

      final ParseResponse response = await queryHostels.query();

      if (response.success && response.results != null) {
        _hotels = response.results as List<ParseObject>;
        print('hotels fetched $_hotels');
        notifyListeners();
      }
    } catch (e, stackTrace) {
      print('error fetching the hostel lists $e and $stackTrace');
    }
  }

  Future<void> fetchHotelById(String hotelId) async {
    try {
      QueryBuilder<ParseObject> queryHotel =
          QueryBuilder<ParseObject>(ParseObject('hostels'))
            ..whereEqualTo('objectId', hotelId);
      final ParseResponse response = await queryHotel.query();

      if (response.success) {
        _hotel = response.results as ParseObject;
        notifyListeners();
      }
    } catch (e, stacktrace) {
      print('error fetching the hotel $e and $stacktrace');
    }
  }

  Future<void> createHostel({
    required String name,
    required String location,
    required String price,
    required String details,
    required String userId,
    required BuildContext context,
    required List<File> imagesPicked,
  }) async {
    try {
      if (name.isNotEmpty &&
          location.isNotEmpty &&
          price.isNotEmpty &&
          details.isNotEmpty &&
          userId.isNotEmpty &&
          imagesPicked != null) {
        // upload image and get the url
        final List<String> imageList = await multipleImageUploads(imagesPicked);
        // final the hotel details
        final hotelData = await ParseObject('hotels')
          ..set('name', name)
          ..set('location', location)
          ..set('price', price)
          ..set('details', details)
          ..set('userId', userId)
          ..set('imageList', imageList);

        final ParseResponse response = await hotelData.save();
        if (response.success) {
          print('the created hostel is ${response.result}');
          _hotels.add(response.result);
          notifyListeners();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Container(
                    decoration: BoxDecoration(color: Colors.green),
                    child: const Text(
                      'Hostel created successfully!',
                    ))),
          );

          Navigator.pushNamed(context, AppRoutes.allHotels);
        }
      } else {
        print('Please add all fields');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please add all fields')),
        );
      }
    } catch (e, stacktrace) {
      print('error creatung hotel $e and $stacktrace');
    }
  }
}
