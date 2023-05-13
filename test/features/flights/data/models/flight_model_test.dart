import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/flights/data/models/airline_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_description_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/juncture_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tAirline = AirlineModel(name: 'Test');

  const tFlightDescription = FlightDescriptionModel(number: 1);

  final tJuncture = JunctureModel(
    airport: 'Test',
    estimated: DateTime.parse('2019-12-12T04:20:00+00:00'),
    timezone: 'Test',
    scheduled: DateTime.parse('2019-12-12T04:20:00+00:00'),
    actual: null,
    gate: 'Test',
    terminal: 'Test',
  );

  final tFlightModel = FlightModel(
    airline: tAirline,
    arrival: tJuncture,
    departure: tJuncture,
    date: DateTime.parse('2019-12-12'),
    flightDescription: tFlightDescription,
    status: 'Test',
  );

  test(
    'should be a subclass of Flight entity',
    () async {
      // assert
      expect(tFlightModel, isA<Flight>());
    },
  );
  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('flight.json'));

        // act
        final result = FlightModel.fromJson(jsonMap);

        // assert
        expect(result, tFlightModel);
      },
    );
  });
}
