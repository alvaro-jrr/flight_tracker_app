import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';

class Flights extends Equatable {
  /// The list of flights.
  final List<Flight> flights;

  const Flights({required this.flights});

  @override
  List<Object> get props => [flights];
}
