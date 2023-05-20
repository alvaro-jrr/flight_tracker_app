import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/use_cases/use_case.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/domain/repositories/airports_repository.dart';

class GetAirportsByCountryCode implements UseCase<List<Airport>, Params> {
  final AirportsRepository repository;

  GetAirportsByCountryCode(this.repository);

  @override
  Future<Either<Failure, List<Airport>>> call(Params params) {
    return repository.getAirportsByCountryCode(params.countryCode);
  }
}

class Params extends Equatable {
  final String countryCode;

  const Params({required this.countryCode});

  @override
  List<Object> get props => [countryCode];
}
