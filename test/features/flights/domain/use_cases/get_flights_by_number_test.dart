import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';
import 'package:flight_tracker_app/features/flights/domain/repositories/flights_repository.dart';
import 'package:flight_tracker_app/features/flights/domain/use_cases/get_flights_by_number.dart';

@GenerateNiceMocks([MockSpec<FlightsRepository>()])
import 'get_flights_by_number_test.mocks.dart';

void main() {
  late MockFlightsRepository mockFlightsRepository;
  late GetFlightsByNumber useCase;

  setUp(() {
    mockFlightsRepository = MockFlightsRepository();
    useCase = GetFlightsByNumber(mockFlightsRepository);
  });

  const tNumber = 'Test';

  final tFlights = Flights(flights: [
    Flight(
      airline: const Airline('Test'),
      arrival: Juncture(
        airport: 'Test',
        estimated: DateTime(2023),
        scheduled: DateTime(2023),
        timezone: 'Test',
      ),
      date: DateTime(2023),
      departure: Juncture(
        airport: 'Test',
        estimated: DateTime(2023),
        scheduled: DateTime(2023),
        timezone: 'Test',
      ),
      status: 'Test',
      flightDescription: const FlightDescription('Test'),
    )
  ]);

  test(
    'should get the flights from the repository',
    () async {
      // arrange
      when(mockFlightsRepository.getFlightsByNumber(any))
          .thenAnswer((_) async => Right(tFlights));

      // act
      final result = await useCase(const Params(number: tNumber));

      // assert
      expect(result, Right(tFlights));
      verify(mockFlightsRepository.getFlightsByNumber(tNumber));
      verifyNoMoreInteractions(mockFlightsRepository);
    },
  );
}
