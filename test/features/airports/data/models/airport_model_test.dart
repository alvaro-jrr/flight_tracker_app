import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/airports/data/models/airport_model.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tAirportModel = AirportModel(
    city: 'Test',
    country: 'Test',
    latitude: 1.0,
    longitude: 1.0,
    name: 'Test',
    region: 'Test',
  );

  test(
    'should be a subclass of Airport entity',
    () async {
      // assert
      expect(tAirportModel, isA<Airport>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('airport.json'));

        // act
        final result = AirportModel.fromJson(jsonMap);

        // assert
        expect(result, tAirportModel);
      },
    );
  });
}
