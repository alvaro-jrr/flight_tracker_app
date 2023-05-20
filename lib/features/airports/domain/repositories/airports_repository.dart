import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

abstract class AirportsRepository {
  /// Gets a list of [Airport] from the country
  /// that matches the [countryCode].
  Future<Either<Failure, List<Airport>>> getAirportsByCountryCode(
    String countryCode,
  );
}
