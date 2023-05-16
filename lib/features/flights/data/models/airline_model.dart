import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';

class AirlineModel extends Airline {
  const AirlineModel({required super.name});

  factory AirlineModel.fromJson(Map<String, dynamic> json) {
    return AirlineModel(name: json['name']);
  }
}
