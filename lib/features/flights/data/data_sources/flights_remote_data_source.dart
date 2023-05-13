import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';

abstract class FlightsRemoteDataSource {
  /// Calls the http://api.aviationstack.com/v1/flights endpoint
  /// with the flight [number].
  ///
  /// Throws a [UsageLimitException] when is reached the usage
  /// limit. Otherwise throws [ServerException] for all
  /// other error codes.
  Future<Flights> getFlightsByNumber(int number);
}
