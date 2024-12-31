import 'dart:io';

import 'package:airlineticket/AppRoutes.dart';
import 'package:airlineticket/base/data/services/multipleImageUpload.dart';
import 'package:airlineticket/base/reuseables/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  Future<void> updateHostel(
      {required String name,
      required String location,
      required String price,
      required String details,
      required String hostelId,
      required String userId,
      List<File>? imagesPicked,
      required BuildContext context}) async {
    print(
        'we expect name $name location $location price $price $hostelId $userId $imagesPicked');
    try {
      if (name.isNotEmpty &&
          location.isNotEmpty &&
          price.isNotEmpty &&
          details.isNotEmpty &&
          hostelId.isNotEmpty &&
          userId.isNotEmpty) {
        // find the user
        final hostelIndex = _hotels.indexWhere(
          (hostel) => hostel.get('objectId') == hostelId,
        );

        final hostelMatch = _hotels[hostelIndex];
        final userIdOfHostel = hostelMatch['userId'];

        if (userIdOfHostel != userId) {
          dialogBuilder(context, 'You are not authorized to edit this post');
          return;
        }

        List<String> imageList = [];
        if (imagesPicked != null && imagesPicked.isNotEmpty) {
          imageList = await multipleImageUploads(imagesPicked);
        }

        if (imageList != null && imageList.isNotEmpty) {
          print('images is $imageList');
          final hotelData = ParseObject('hotels')
            ..objectId = hostelId
            ..set('name', name)
            ..set('location', location)
            ..set('price', price)
            ..set('details', details)
            ..set('imageList', imageList);

          final ParseResponse response = await hotelData.save();
          if (response.success) {
            print('popkljhb');
            print('the img updated hostel is ${response.result}');
            _hotels[hostelIndex] = response.result;
            print('hotel is ${_hotels[hostelIndex]}');
            notifyListeners();
            print('now navi');
            Navigator.pushNamed(context, AppRoutes.allHotels);
          }
        } else {
          final hotelData = await ParseObject('hotels')
            ..objectId = hostelId
            ..set('name', name)
            ..set('location', location)
            ..set('price', price)
            ..set('details', details);

          final ParseResponse response = await hotelData.save();
          if (response.success) {
            _hotels[hostelIndex] = response.result;
            print('the no img updated hostel is ${response.result}');
            notifyListeners();
            Navigator.pushNamed(context, AppRoutes.allHotels);
          }
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please add all fields')));
      }
    } catch (e, stackTrace) {
      print('error editing hotel $e and $stackTrace ');
    }
  }

  Future<void> deleteHostel(
      String hostelId, String userId, BuildContext context) async {
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
                'Are you sure you want to delete this hostel?',
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

      final gethostel = await ParseObject('hotels').getObject(hostelId);
      String hostelUserId = '';
      if (gethostel.success) {
        final hostelDetails = gethostel.result;
        hostelUserId = hostelDetails.get<String>('userId');
      }
      final ParseObject hostel = ParseObject('hotels')..objectId = hostelId;

      final ParseResponse response = await hostel.delete();
      print('got the hostel id to delete is: $hostel $response $hostelUserId');

      if (response.success) {
        _hotels.removeWhere((t) => t.objectId == hostelId);
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('hostel successfully deleted')));
        Navigator.pushNamed(context, AppRoutes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('hostel failed to deleted')));
        print(
            'error deleting hostel ${response.error?.message}  ${response.error?.exception}');
      }
    } catch (e) {
      print('Error delete hostel: $e');
    }
  }
}
