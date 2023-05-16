import 'package:equatable/equatable.dart';

class FlightDescription extends Equatable {
  /// The flight number.
  final int number;

  const FlightDescription({required this.number});

  @override
  List<Object> get props => [number];
}
