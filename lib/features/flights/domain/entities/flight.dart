import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

class Flight extends Equatable {
  final Airline airline;
  final Juncture arrival;
  final DateTime date;
  final Juncture departure;
  final String status;
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
