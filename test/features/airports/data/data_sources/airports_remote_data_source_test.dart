import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/env/env.dart';
import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/features/airports/data/data_sources/airports_remote_data_source.dart';
import 'package:flight_tracker_app/features/airports/data/models/airport_model.dart';

import '../../../../fixtures/fixture_reader.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'airports_remote_data_source_test.mocks.dart';

void main() {
  late MockClient mockClient;
  late AirportsRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockClient = MockClient();
    dataSourceImpl = AirportsRemoteDataSourceImpl(client: mockClient);
  });

  const tCountryCode = 'Test';

  const tAirports = [
    AirportModel(
      city: 'Test',
      country: 'Test',
      latitude: 1.0,
      longitude: 1.0,
      name: 'Test',
      region: 'Test',
    ),
  ];

  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('airports.json'), 200));
  }

  group('getAirportsByCountryCode', () {
    test(
      '''should perform a GET request on a URL with the query
      being the search param and with the application/json header''',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getAirportsByCountryCode(tCountryCode);

        // assert
        verify(
          mockClient.get(
            Uri.http(
              'api.api-ninjas.com',
              '/v1/airports',
              {
                'country': tCountryCode,
              },
            ),
            headers: {
              'Content-Type': 'application/json',
              'X-Api-Key': Env.apiNinjasApiKey,
            },
          ),
        );
      },
    );

    test(
      'should return the Airport list when status code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final result =
            await dataSourceImpl.getAirportsByCountryCode(tCountryCode);

        // assert
        expect(result, tAirports);
      },
    );

    test(
      'should throw a ServerException when the status code is 404 or other',
      () async {
        // arrange
        when(mockClient.get(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response('Server Error', 404));

        // act
        final call = dataSourceImpl.getAirportsByCountryCode;

        // assert
        expect(
          () => call(tCountryCode),
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
        final call = dataSourceImpl.getAirportsByCountryCode;

        // assert
        expect(
          () => call(tCountryCode),
          throwsA(const TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
