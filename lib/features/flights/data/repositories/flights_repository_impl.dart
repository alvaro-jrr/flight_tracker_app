import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/network/network_info.dart';
import 'package:flight_tracker_app/features/flights/data/data_sources/flights_remote_data_source.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/domain/repositories/flights_repository.dart';

class FlightsRepositoryImpl implements FlightsRepository {
  final FlightsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  FlightsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Flights>> getFlightsByNumber(int number) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      return Right(await remoteDataSource.getFlightsByNumber(number));
    } on UsageLimitException {
      return Left(UsageLimitFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
