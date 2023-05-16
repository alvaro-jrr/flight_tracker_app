import 'package:equatable/equatable.dart';

class Airline extends Equatable {
  /// The name of the airline.
  final String name;

  const Airline({required this.name});

  @override
  List<Object> get props => [name];
}
