import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';
import 'package:flight_tracker_app/core/utils/input_converter.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/airline.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';
import 'package:flight_tracker_app/features/flights/domain/use_cases/get_flights_by_number.dart';
import 'package:flight_tracker_app/features/flights/presentation/bloc/flights_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetFlightsByNumber>(),
  MockSpec<InputConverter>(),
])
import 'flights_bloc_test.mocks.dart';

void main() {
  late MockGetFlightsByNumber mockGetFlightsByNumber;
  late MockInputConverter mockInputConverter;
  late FlightsBloc bloc;

  setUp(() {
    mockGetFlightsByNumber = MockGetFlightsByNumber();
    mockInputConverter = MockInputConverter();

    bloc = FlightsBloc(
      getFlightsByNumber: mockGetFlightsByNumber,
      inputConverter: mockInputConverter,
    );
  });

  const tNumberString = '1';
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

  final tFlights = Flights(
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

  test(
    'initial state should be empty',
    () async {
      // assert
      expect(bloc.state, Empty());
    },
  );

  void setUpMockInputConverterSuccess() {
    when(mockInputConverter.stringToUnsignedInteger(any))
        .thenAnswer((_) => const Right(tNumber));
  }

  void setUpSucessfullCall() {
    setUpMockInputConverterSuccess();

    when(mockGetFlightsByNumber(any)).thenAnswer((_) async => Right(tFlights));
  }

  group('GetFlightsFromConcreteFlightNumber', () {
    test(
      'should call the InputConverter to convert the number',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetFlightsByNumber(any))
            .thenAnswer((_) async => Right(tFlights));

        // act
        bloc.add(const GetFlightsFromConcreteFlightNumber(tNumberString));
        await untilCalled(mockInputConverter.stringToUnsignedInteger(any));

        // assert
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenAnswer((_) => Left(InvalidInputFailure()));

        // assert later
        const expected = [
          Error(message: invalidInputMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetFlightsFromConcreteFlightNumber(tNumberString));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpSucessfullCall();

        // act
        bloc.add(const GetFlightsFromConcreteFlightNumber(tNumberString));
        await untilCalled(mockGetFlightsByNumber(any));

        // assert
        verify(mockGetFlightsByNumber(const Params(number: tNumber)));
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetFlightsByNumber(any))
            .thenAnswer((_) async => Right(tFlights));

        // assert later
        final expected = [
          Loading(),
          Loaded(flights: tFlights),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetFlightsFromConcreteFlightNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetFlightsByNumber(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetFlightsFromConcreteFlightNumber(tNumberString));
      },
    );
  });
}
