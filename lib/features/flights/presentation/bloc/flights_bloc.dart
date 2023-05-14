import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';

part 'flights_event.dart';
part 'flights_state.dart';

class FlightsBloc extends Bloc<FlightsEvent, FlightsState> {
  FlightsBloc() : super(Empty()) {
    on<FlightsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
