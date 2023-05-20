import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:flight_tracker_app/core/network/network_info.dart';
import 'package:flight_tracker_app/core/utils/input_converter.dart';
import 'package:flight_tracker_app/features/airports/data/data_sources/airports_remote_data_source.dart';
import 'package:flight_tracker_app/features/airports/data/repositories/airports_repository_impl.dart';
import 'package:flight_tracker_app/features/airports/domain/repositories/airports_repository.dart';
import 'package:flight_tracker_app/features/airports/domain/use_cases/get_airports_by_country_code.dart';
import 'package:flight_tracker_app/features/airports/presentation/bloc/airports_bloc.dart';
import 'package:flight_tracker_app/features/flights/data/data_sources/flights_remote_data_source.dart';
import 'package:flight_tracker_app/features/flights/data/repositories/flights_repository_impl.dart';
import 'package:flight_tracker_app/features/flights/domain/repositories/flights_repository.dart';
import 'package:flight_tracker_app/features/flights/domain/use_cases/get_flights_by_number.dart';
import 'package:flight_tracker_app/features/flights/presentation/bloc/flights_bloc.dart';

final sl = GetIt.instance;

void init() {
  //* Features - Flights
  // Bloc.
  sl.registerFactory(
    () => FlightsBloc(
      getFlightsByNumber: sl(),
      inputConverter: sl(),
    ),
  );

  // Use Cases.
  sl.registerLazySingleton(() => GetFlightsByNumber(sl()));

  // Repository.
  sl.registerLazySingleton<FlightsRepository>(
    () => FlightsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources.
  sl.registerLazySingleton<FlightsRemoteDataSource>(
    () => FlightsRemoteDataSourceImpl(client: sl()),
  );

  //* Features - Airports
  // Bloc.
  sl.registerFactory(
    () => AirportsBloc(
      getAirportsByCountryCode: sl(),
      inputConverter: sl(),
    ),
  );

  // Use Cases.
  sl.registerLazySingleton(() => GetAirportsByCountryCode(sl()));

  // Repository.
  sl.registerLazySingleton<AirportsRepository>(
    () => AirportsRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data Sources.
  sl.registerLazySingleton<AirportsRemoteDataSource>(
    () => AirportsRemoteDataSourceImpl(client: sl()),
  );

  //* Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //* External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
