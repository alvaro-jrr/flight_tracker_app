import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/utils/constants.dart';
import 'package:flight_tracker_app/core/utils/input_converter.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/domain/use_cases/get_airports_by_country_code.dart';
import 'package:flight_tracker_app/features/airports/presentation/bloc/airports_bloc.dart';

@GenerateNiceMocks([
  MockSpec<GetAirportsByCountryCode>(),
  MockSpec<InputConverter>(),
])
import 'airports_bloc_test.mocks.dart';

void main() {
  late MockGetAirportsByCountryCode mockGetAirportsByCountryCode;
  late MockInputConverter mockInputConverter;
  late AirportsBloc bloc;

  setUp(() {
    mockGetAirportsByCountryCode = MockGetAirportsByCountryCode();
    mockInputConverter = MockInputConverter();

    bloc = AirportsBloc(
      getAirportsByCountryCode: mockGetAirportsByCountryCode,
      inputConverter: mockInputConverter,
    );
  });

  const tCountryCode = 'Test';

  const tAirports = [
    Airport(
      city: 'Test',
      country: 'Test',
      latitude: 1.0,
      longitude: 1.0,
      name: 'Test',
      region: 'Test',
    ),
  ];

  test(
    'initial state should be empty',
    () async {
      // assert
      expect(bloc.state, Empty());
    },
  );

  void setUpMockInputConverterSuccess() {
    when(mockInputConverter.stringToCountryCode(any))
        .thenAnswer((_) => const Right(tCountryCode));
  }

  void setUpSucessfullCall() {
    setUpMockInputConverterSuccess();

    when(mockGetAirportsByCountryCode(any))
        .thenAnswer((_) async => const Right(tAirports));
  }

  group('GetAirportsFromConcreteCountryCode', () {
    test(
      'should call the InputConverter to convert the string to country code',
      () async {
        // arrange
        setUpSucessfullCall();

        // act
        bloc.add(const GetAirportsFromConcreteCountryCode(tCountryCode));
        await untilCalled(mockInputConverter.stringToCountryCode(any));

        // assert
        verify(mockInputConverter.stringToCountryCode(tCountryCode));
      },
    );

    test(
      'should emit [Error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToCountryCode(any))
            .thenAnswer((_) => Left(InvalidInputFailure()));

        // assert later
        const expected = [
          Error(message: invalidInputMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // assert
        bloc.add(const GetAirportsFromConcreteCountryCode(tCountryCode));
      },
    );

    test(
      'should get data from the concrete use case',
      () async {
        // arrange
        setUpSucessfullCall();

        // act
        bloc.add(const GetAirportsFromConcreteCountryCode(tCountryCode));
        await untilCalled(mockGetAirportsByCountryCode(any));

        // assert
        verify(
          mockGetAirportsByCountryCode(
            const Params(countryCode: tCountryCode),
          ),
        );
      },
    );

    test(
      'should emit [Loading, Loaded] when data is gotten successfully',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetAirportsByCountryCode(any))
            .thenAnswer((_) async => const Right(tAirports));

        // assert later
        final expected = [
          Loading(),
          const Loaded(airports: tAirports),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetAirportsFromConcreteCountryCode(tCountryCode));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        setUpMockInputConverterSuccess();

        when(mockGetAirportsByCountryCode(any))
            .thenAnswer((_) async => Left(ServerFailure()));

        // assert later
        final expected = [
          Loading(),
          const Error(message: serverFailureMessage),
        ];

        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(const GetAirportsFromConcreteCountryCode(tCountryCode));
      },
    );
  });
}
