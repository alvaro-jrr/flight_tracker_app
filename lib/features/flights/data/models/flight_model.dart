import 'package:flight_tracker_app/features/flights/data/models/airline_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_description_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/juncture_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';

class FlightModel extends Flight {
  const FlightModel({
    required super.airline,
    required super.arrival,
    required super.date,
    required super.departure,
    required super.status,
    required super.flightDescription,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      airline: AirlineModel.fromJson(json['airline']),
      arrival: JunctureModel.fromJson(json['arrival']),
      date: DateTime.parse(json['flight_date']),
      departure: JunctureModel.fromJson(json['departure']),
      status: json['flight_status'],
      flightDescription: FlightDescriptionModel.fromJson(json['flight']),
    );
  }
}
