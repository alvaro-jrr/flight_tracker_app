import 'package:equatable/equatable.dart';

class Juncture extends Equatable {
  /// The actual date and time.
  final DateTime? actual;

  /// The airport name of the juncture.
  final String airport;

  /// The estimated date and time.
  final DateTime estimated;

  /// The gate of the juncture.
  final String? gate;

  /// The scheduled date and time.
  final DateTime scheduled;

  /// The terminal of the juncture.
  final String? terminal;

  /// The timezone of the juncture.
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
