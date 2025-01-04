import 'package:latlong2/latlong.dart';

class MarkData {
  final LatLng location;
  final String title;
  final String description;

  MarkData({
    required this.location,
    required this.title,
    required this.description,
  });
}
