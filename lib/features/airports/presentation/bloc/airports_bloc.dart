import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

part 'airports_event.dart';
part 'airports_state.dart';

class AirportsBloc extends Bloc<AirportsEvent, AirportsState> {
  AirportsBloc() : super(Empty()) {
    on<AirportsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
