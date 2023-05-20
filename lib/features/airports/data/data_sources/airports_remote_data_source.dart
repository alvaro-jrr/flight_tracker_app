import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flight_tracker_app/core/env/env.dart';
import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/features/airports/data/models/airport_model.dart';

abstract class AirportsRemoteDataSource {
  /// Calls the https://api.api-ninjas.com/v1/airports endpoint
  /// with the [countryCode] search param.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<AirportModel>> getAirportsByCountryCode(String countryCode);
}

class AirportsRemoteDataSourceImpl implements AirportsRemoteDataSource {
  final http.Client client;

  AirportsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AirportModel>> getAirportsByCountryCode(
    String countryCode,
  ) async {
    try {
      final response = await client.get(
        Uri.http(
          'api.api-ninjas.com',
          '/v1/airports',
          {
            'country': countryCode,
          },
        ),
        headers: {
          'Content-Type': 'application/json',
          'X-Api-Key': Env.apiNinjasApiKey,
        },
      );

      if (response.statusCode != 200) throw ServerException();

      final List<dynamic> airportsJson = json.decode(response.body);

      return List.from(
        airportsJson.map((airportJson) {
          return AirportModel.fromJson(airportJson);
        }),
      );
    } on http.ClientException {
      throw ServerException();
    }
  }
}
