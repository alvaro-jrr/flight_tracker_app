part of 'airports_bloc.dart';

abstract class AirportsState extends Equatable {
  const AirportsState();

  @override
  List<Object> get props => [];
}

class Empty extends AirportsState {}

class Loading extends AirportsState {}

class Loaded extends AirportsState {
  final List<Airport> airports;

  const Loaded({required this.airports});

  @override
  List<Object> get props => [airports];
}

class Error extends AirportsState {
  final String message;

  const Error({required this.message});

  @override
  List<Object> get props => [message];
}
