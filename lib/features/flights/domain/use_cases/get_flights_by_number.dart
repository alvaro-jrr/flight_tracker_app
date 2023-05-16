import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/use_cases/use_case.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/domain/repositories/flights_repository.dart';

class GetFlightsByNumber implements UseCase<Flights, Params> {
  final FlightsRepository repository;

  GetFlightsByNumber(this.repository);

  @override
  Future<Either<Failure, Flights>> call(Params params) {
    return repository.getFlightsByNumber(params.number);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object> get props => [number];
}
