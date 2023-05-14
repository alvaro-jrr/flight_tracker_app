part of 'flights_bloc.dart';

abstract class FlightsEvent extends Equatable {
  const FlightsEvent();

  @override
  List<Object> get props => [];
}

class GetFlightsFromConcreteFlightNumber extends FlightsEvent {
  final String flightNumberString;

  const GetFlightsFromConcreteFlightNumber(this.flightNumberString);

  @override
  List<Object> get props => [flightNumberString];
}
