import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/flights/data/models/airline_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tAirlineModel = AirlineModel(name: 'Test');

  test(
    'should be a subclass of Airline entity',
    () async {
      // assert
      expect(tAirlineModel, isA<Airline>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('airline.json'));

        // act
        final result = AirlineModel.fromJson(jsonMap);

        // assert
        expect(result, tAirlineModel);
      },
    );
  });
}
