import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

class JunctureModel extends Juncture {
  const JunctureModel({
    required super.airport,
    required super.estimated,
    required super.iata,
    required super.scheduled,
    required super.timezone,
    super.actual,
    super.gate,
    super.terminal,
  });

  factory JunctureModel.fromJson(Map<String, dynamic> json) {
    return JunctureModel(
      airport: json['airport'],
      estimated: DateTime.parse(json['estimated']),
      iata: json['iata'],
      scheduled: DateTime.parse(json['scheduled']),
      timezone: json['timezone'],
      actual: json['actual'] != null ? DateTime.parse(json['actual']) : null,
      gate: json['gate'],
      terminal: json['terminal'],
    );
  }
}
