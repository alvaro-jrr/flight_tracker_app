import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

class Flight extends Equatable {
  /// The airline that handle the flight.
  final Airline airline;

  /// The information about the arrival.
  final Juncture arrival;

  /// The date of the flight.
  final DateTime date;

  /// The information about the departure.
  final Juncture departure;

  /// The status of the flight.
  final String status;

  /// More description of the flight.
  final FlightDescription flightDescription;

  const Flight({
    required this.airline,
    required this.arrival,
    required this.date,
    required this.departure,
    required this.status,
    required this.flightDescription,
  });

  @override
  List<Object> get props {
    return [
      airline,
      arrival,
      date,
      departure,
      status,
      flightDescription,
    ];
  }
}
