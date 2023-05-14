import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/env/env.dart';
import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/features/flights/data/data_sources/flights_remote_data_source.dart';
import 'package:flight_tracker_app/features/flights/data/models/airline_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_description_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flight_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/flights_model.dart';
import 'package:flight_tracker_app/features/flights/data/models/juncture_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'flights_remote_data_source_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late FlightsRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    dataSourceImpl = FlightsRemoteDataSourceImpl(client: mockClient);
  });

  const tNumber = 1;

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
      ),
    ],
  );

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('flights.json'), 200));
  }

  group('getFlightsByNumber', () {
    test(
      '''should perform a GET request on a URL with the query
      being the search param and with the application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getFlightsByNumber(tNumber);

        // assert
        verify(
          mockClient.get(
            Uri.http(
              'api.aviationstack.com',
              '/v1/flights',
              {
                'access_key': Env.aviationStackApiKey,
                'flight_number': '$tNumber',
              },
            ),
            headers: {'Content-Type': 'application/json'},
          ),
        );
      },
    );

    test(
      'should return the FlightsModel when status code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result = await dataSourceImpl.getFlightsByNumber(tNumber);

        // assert
        expect(result, tFlightsModel);
      },
    );

    test(
      'should throw a UsageLimitException when the status code is 429',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Usage Limit Reached', 429));

        // act
        final call = dataSourceImpl.getFlightsByNumber;

        // assert
        expect(
          () => call(tNumber),
          throwsA(const TypeMatcher<UsageLimitException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the status code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Server Error', 404));

        // act
        final call = dataSourceImpl.getFlightsByNumber;

        // assert
        expect(
          () => call(tNumber),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the call throws a ClientException',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenThrow(http.ClientException(''));

        // act
        final call = dataSourceImpl.getFlightsByNumber;

        // assert
        expect(
          () => call(tNumber),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
