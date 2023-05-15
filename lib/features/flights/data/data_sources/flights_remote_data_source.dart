import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flight_tracker_app/core/env/env.dart';
import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/features/flights/data/models/flights_model.dart';

abstract class FlightsRemoteDataSource {
  /// Calls the http://api.aviationstack.com/v1/flights endpoint
  /// with the flight [number].
  ///
  /// Throws a [UsageLimitException] when is reached the usage
  /// limit. Otherwise throws [ServerException] for all
  /// other error codes.
  Future<FlightsModel> getFlightsByNumber(int number);
}

class FlightsRemoteDataSourceImpl implements FlightsRemoteDataSource {
  final http.Client client;

  FlightsRemoteDataSourceImpl({required this.client});

  @override
  Future<FlightsModel> getFlightsByNumber(int number) async {
    try {
      final response = await client.get(
        Uri.http(
          'api.aviationstack.com',
          '/v1/flights',
          {
            'access_key': Env.aviationStackApiKey,
            'limit': '25',
            'flight_number': '$number',
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 429) throw UsageLimitException();

      if (response.statusCode != 200) throw ServerException();

      return FlightsModel.fromJson(json.decode(response.body));
    } on http.ClientException {
      throw ServerException();
    }
  }
}
