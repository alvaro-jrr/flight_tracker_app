import 'package:dartz/dartz.dart';

import 'package:flight_tracker_app/core/error/exceptions.dart';
import 'package:flight_tracker_app/core/error/failures.dart';
import 'package:flight_tracker_app/core/network/network_info.dart';
import 'package:flight_tracker_app/features/airports/data/data_sources/airports_remote_data_source.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/domain/repositories/airports_repository.dart';

class AirportsRepositoryImpl implements AirportsRepository {
  final AirportsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AirportsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Airport>>> getAirportsByCountryCode(
    String countryCode,
  ) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) return Left(NoInternetConnectionFailure());

    try {
      return Right(
        await remoteDataSource.getAirportsByCountryCode(countryCode),
      );
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
