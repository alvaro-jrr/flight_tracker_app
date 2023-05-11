import 'package:equatable/equatable.dart';

class Juncture extends Equatable {
  final DateTime? actual;
  final String airport;
  final DateTime estimated;
  final String? gate;
  final DateTime scheduled;
  final String? terminal;
  final String timezone;

  const Juncture({
    this.actual,
    required this.airport,
    required this.estimated,
    this.gate,
    required this.scheduled,
    this.terminal,
    required this.timezone,
  });

  @override
  List<Object> get props => [airport, estimated, scheduled, timezone];
}
