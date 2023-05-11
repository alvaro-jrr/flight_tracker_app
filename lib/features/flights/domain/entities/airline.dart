import 'package:equatable/equatable.dart';

class Airline extends Equatable {
  final String name;

  const Airline(this.name);

  @override
  List<Object> get props => [name];
}
