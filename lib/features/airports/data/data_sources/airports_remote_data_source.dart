import 'package:flight_tracker_app/features/airports/data/models/airport_model.dart';

abstract class AirportsRemoteDataSource {
  /// Calls the https://api.api-ninjas.com/v1/airports endpoint
  /// with the [countryCode] search param.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<AirportModel>> getAirportsByCountryCode(String countryCode);
}
