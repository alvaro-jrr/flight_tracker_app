import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/core/utils/input_converter.dart';
import 'package:flight_tracker_app/core/utils/utils.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/domain/use_cases/get_airports_by_country_code.dart';

part 'airports_event.dart';
part 'airports_state.dart';

const invalidInputMessage = 'Debe ingresar un código de país de dos letras';

class AirportsBloc extends Bloc<AirportsEvent, AirportsState> {
  final GetAirportsByCountryCode getAirportsByCountryCode;
  final InputConverter inputConverter;

  AirportsBloc({
    required this.getAirportsByCountryCode,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetAirportsFromConcreteCountryCode>((event, emit) async {
      final failureOrCountryCode = inputConverter.stringToCountryCode(
        event.countryCode,
      );

      emit(
        await failureOrCountryCode.fold(
          (_) async => const Error(message: invalidInputMessage),
          (countryCode) async {
            emit(Loading());

            final failureOrAirports = await getAirportsByCountryCode(
              Params(countryCode: countryCode),
            );

            return failureOrAirports.fold(
              (failure) => Error(message: mapFailureToMessage(failure)),
              (airports) => Loaded(airports: airports),
            );
          },
        ),
      );
    });
  }
}
