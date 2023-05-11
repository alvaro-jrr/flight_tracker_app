import 'package:equatable/equatable.dart';

class FlightDescription extends Equatable {
  /// The flight number.
  final String number;

  const FlightDescription(this.number);

  @override
  List<Object> get props => [number];
}
