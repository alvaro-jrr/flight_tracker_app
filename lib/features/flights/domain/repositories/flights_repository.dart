import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';

abstract class FlightsRepository {
  /// Gets a [Flights] response that matches the flight [number].
  Future<Either<Failure, Flights>> getFlightsByNumber(String number);
}
