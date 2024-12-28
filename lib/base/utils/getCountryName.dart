import 'package:airlineticket/base/reuseables/resources/countries.dart';

String? getCountryName(String code) {
  final country = abbreviatedCountries.firstWhere(
    (country) => country['code'] == code,
    orElse: () => <String, String>{},
  );
  return country?['name'];
}
