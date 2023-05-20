import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/domain/repositories/airports_repository.dart';
import 'package:flight_tracker_app/features/airports/domain/use_cases/get_airports_by_country_code.dart';

@GenerateNiceMocks([MockSpec<AirportsRepository>()])
import 'get_airports_by_country_code_test.mocks.dart';

void main() {
  late MockAirportsRepository mockAirportsRepository;
  late GetAirportsByCountryCode useCase;

  setUp(() {
    mockAirportsRepository = MockAirportsRepository();
    useCase = GetAirportsByCountryCode(mockAirportsRepository);
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
    'should get the airports from the repository',
    () async {
      // arrange
      when(mockAirportsRepository.getAirportsByCountryCode(any))
          .thenAnswer((_) async => const Right(tAirports));

      // act
      final result = await useCase(const Params(countryCode: tCountryCode));

      // assert
      expect(result, const Right(tAirports));
      verify(mockAirportsRepository.getAirportsByCountryCode(tCountryCode));
      verifyNoMoreInteractions(mockAirportsRepository);
    },
  );
}
