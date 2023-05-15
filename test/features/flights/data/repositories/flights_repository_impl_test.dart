import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/network/network_info.dart';
import 'package:flight_tracker_app/features/flights/data/data_sources/flights_remote_data_source.dart';
import 'package:flight_tracker_app/features/flights/data/models/flights_model.dart';
import 'package:flight_tracker_app/features/flights/data/repositories/flights_repository_impl.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

@GenerateNiceMocks([
  MockSpec<FlightsRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'flights_repository_impl_test.mocks.dart';

void main() {
  late MockFlightsRemoteDataSource mockFlightsRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late FlightsRepositoryImpl repository;

  setUp(() {
    mockFlightsRemoteDataSource = MockFlightsRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = FlightsRepositoryImpl(
      remoteDataSource: mockFlightsRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tNumber = 1;

  final tJuncture = Juncture(
    airport: 'Test',
    estimated: DateTime.parse('2019-12-12T04:20:00+00:00'),
    iata: 'Test',
    timezone: 'Test',
    scheduled: DateTime.parse('2019-12-12T04:20:00+00:00'),
    actual: null,
    gate: 'Test',
    terminal: 'Test',
  );

  final tFlightsModel = FlightsModel(
    flights: [
      Flight(
        airline: const Airline(name: 'Test'),
        arrival: tJuncture,
        departure: tJuncture,
        date: DateTime.parse('2019-12-12'),
        flightDescription: const FlightDescription(number: 1),
        status: 'Test',
      ),
    ],
  );

  group('getFlightsByNumber', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        repository.getFlightsByNumber(tNumber);

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
          when(mockFlightsRemoteDataSource.getFlightsByNumber(any))
              .thenAnswer((_) async => tFlightsModel);

          // act
          final result = await repository.getFlightsByNumber(tNumber);

          // assert
          verify(mockFlightsRemoteDataSource.getFlightsByNumber(tNumber));
          expect(result, Right(tFlightsModel));
        },
      );

      test(
        'should return UsageLimitFailure when the call to remote data answers with UsageLimitException',
        () async {
          // arrange
          when(mockFlightsRemoteDataSource.getFlightsByNumber(any))
              .thenThrow(UsageLimitException());

          // act
          final result = await repository.getFlightsByNumber(tNumber);

          // assert
          verify(mockFlightsRemoteDataSource.getFlightsByNumber(tNumber));
          expect(result, Left(UsageLimitFailure()));
        },
      );

      test(
        'should return ServerFailure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockFlightsRemoteDataSource.getFlightsByNumber(any))
              .thenThrow(ServerException());

          // act
          final result = await repository.getFlightsByNumber(tNumber);

          // assert
          verify(mockFlightsRemoteDataSource.getFlightsByNumber(tNumber));
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
          final result = await repository.getFlightsByNumber(tNumber);

          // assert
          verifyZeroInteractions(mockFlightsRemoteDataSource);
          expect(result, Left(NoInternetConnectionFailure()));
        },
      );
    });
  });
}
