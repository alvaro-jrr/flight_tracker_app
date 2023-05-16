import 'package:equatable/equatable.dart';

class Airport extends Equatable {
  // The city where is located the airport.
  final String city;

  // The country where is located the airport.
  final String country;

  // The latitude position of the airport.
  final double latitude;

  // The longitude position of the airport.
  final double longitude;

  // The name of the airport.
  final String name;

  // The region where is located the airport.
  final String region;

  const Airport({
    required this.city,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.region,
  });

  @override
  List<Object> get props => [city, country, latitude, longitude, name, region];
}
