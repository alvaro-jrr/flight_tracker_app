part of 'flights_bloc.dart';

abstract class FlightsState extends Equatable {
  const FlightsState();

  @override
  List<Object> get props => [];
}

class Empty extends FlightsState {}

class Loading extends FlightsState {}

class LoadedFlights extends FlightsState {
  final Flights flights;

  const LoadedFlights({required this.flights});

  @override
  List<Object> get props => [flights];
}

class Error extends FlightsState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
