import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/flights/data/models/airline_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_description_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flights_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/juncture_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tJuncture = JunctureModel(
    airport: 'Test',
    estimated: DateTime.parse('2019-12-12T04:20:00+00:00'),
    timezone: 'Test',
    scheduled: DateTime.parse('2019-12-12T04:20:00+00:00'),
    actual: null,
    gate: 'Test',
    terminal: 'Test',
  );

  final tFlightsModel = FlightsModel(
    flights: [
      FlightModel(
        airline: const AirlineModel(name: 'Test'),
        arrival: tJuncture,
        departure: tJuncture,
        date: DateTime.parse('2019-12-12'),
        flightDescription: const FlightDescriptionModel(number: 1),
        status: 'Test',
      )
    ],
  );

  test(
    'should be a subclass of Flights entity',
    () async {
      // assert
      expect(tFlightsModel, isA<Flights>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('flights.json'));

        // act
        final result = FlightsModel.fromJson(jsonMap);

        // assert
        expect(result, tFlightsModel);
      },
    );
  });
}
