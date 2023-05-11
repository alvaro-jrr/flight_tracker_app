import 'package:equatable/equatable.dart';

class FlightDescription extends Equatable {
  final String number;

  const FlightDescription(this.number);

  @override
  List<Object> get props => [number];
}
