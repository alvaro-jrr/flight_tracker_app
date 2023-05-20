import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

class AirportModel extends Airport {
  const AirportModel({
    required super.city,
    required super.country,
    required super.latitude,
    required super.longitude,
    required super.name,
    required super.region,
  });

  factory AirportModel.fromJson(Map<String, dynamic> json) {
    return AirportModel(
      city: json['city'],
      country: json['country'],
      latitude: double.parse(json['latitude']),
      longitude: double.parse(json['longitude']),
      name: json['name'],
      region: json['region'],
    );
  }
}
