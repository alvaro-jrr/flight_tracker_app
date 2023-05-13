import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import 'package:flight_tracker_app/features/flights/data/models/juncture_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tJunctureModel = JunctureModel(
    airport: 'Test',
    estimated: DateTime.parse('2019-12-12T04:20:00+00:00'),
    timezone: 'Test',
    scheduled: DateTime.parse('2019-12-12T04:20:00+00:00'),
    actual: null,
    gate: 'Test',
    terminal: 'Test',
  );

  test(
    'should be a subclass of Juncture entity',
    () async {
      // assert
      expect(tJunctureModel, isA<Juncture>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixture('juncture.json'));

        // act
        final result = JunctureModel.fromJson(jsonMap);

        // assert
        expect(result, tJunctureModel);
      },
    );
  });
}
