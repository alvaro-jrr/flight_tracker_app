part of 'airports_bloc.dart';

abstract class AirportsEvent extends Equatable {
  const AirportsEvent();

  @override
  List<Object> get props => [];
}

class GetAirportsFromConcreteCountryCode extends AirportsEvent {
  final String countryCode;

  const GetAirportsFromConcreteCountryCode(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
