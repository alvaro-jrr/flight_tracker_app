import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/network/network_info.dart';
import 'package:flight_tracker_app/features/airports/data/data_sources/airports_remote_data_source.dart';
import 'package:flight_tracker_app/features/airports/data/models/airport_model.dart';
import 'package:flight_tracker_app/features/airports/data/repositories/airports_repository_impl.dart';

@GenerateNiceMocks([
  MockSpec<AirportsRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'airports_repository_impl_test.mocks.dart';

void main() {
  late MockAirportsRemoteDataSource mockAirportsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late AirportsRepositoryImpl repository;

  setUp(() {
    mockAirportsRemoteDataSource = MockAirportsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = AirportsRepositoryImpl(
      remoteDataSource: mockAirportsRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
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

  group('getAirportsByCountryCode', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getAirportsByCountryCode(tCountryCode);

        // assert
        verify(mockNetworkInfo.isConnected);
      },
    );

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(mockAirportsRemoteDataSource.getAirportsByCountryCode(any))
              .thenAnswer((_) async => tAirports);

          // act
          final result =
              await repository.getAirportsByCountryCode(tCountryCode);

          // assert
          verify(mockAirportsRemoteDataSource
              .getAirportsByCountryCode(tCountryCode));
          expect(result, const Right(tAirports));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockAirportsRemoteDataSource.getAirportsByCountryCode(any))
              .thenThrow(ServerException());

          // act
          final result =
              await repository.getAirportsByCountryCode(tCountryCode);

          // assert
          verify(mockAirportsRemoteDataSource
              .getAirportsByCountryCode(tCountryCode));
          expect(result, Left(ServerFailure()));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return NoInternetConnectionFailure when device is offline',
        () async {
          // act
          final result = await repository.getAirportsByCountryCode(
            tCountryCode,
          );

          // assert
          verifyZeroInteractions(mockAirportsRemoteDataSource);
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });
}
