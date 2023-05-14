import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/core/utils/input_converter.dart';
import 'package:flight_tracker_app/core/utils/utils.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/domain/use_cases/get_flights_by_number.dart';

part 'flights_event.dart';
part 'flights_state.dart';

const invalidInputMessage = 'Debe ingresar un número mayor que 0';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  final GetFlightsByNumber getFlightsByNumber;
  final InputConverter inputConverter;

  FlightsBloc({
    required this.getFlightsByNumber,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetFlightsFromConcreteFlightNumber>((event, emit) async {
      final failureOrNumber = inputConverter.stringToUnsignedInteger(
        event.flightNumberString,
      );

      emit(
        await failureOrNumber.fold(
          (failure) async {
            return const Error(message: invalidInputMessage);
          },
          (number) async {
            emit(Loading());

            final failureOrFlights = await getFlightsByNumber(
              Params(number: number),
            );

            return failureOrFlights.fold(
              (failure) {
                return Error(message: mapFailureToMessage(failure));
              },
              (flights) {
                return Loaded(flights: flights);
              },
            );
          },
        ),
      );
    });
  }
}
