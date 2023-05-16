import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/flights/data/models/flight_description_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tFlightDescriptionModel = FlightDescriptionModel(number: 1);

  test(
    'should be a subclass of FlightDescription entity',
    () async {
      // assert
      expect(tFlightDescriptionModel, isA<FlightDescription>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('flight_description.json'));

        // act
        final result = FlightDescriptionModel.fromJson(jsonMap);

        // assert
        expect(result, tFlightDescriptionModel);
      },
    );
  });
}
