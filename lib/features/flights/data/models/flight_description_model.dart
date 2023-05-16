import 'package:flight_tracker_app/features/flights/domain/entities/flight_description.dart';

class FlightDescriptionModel extends FlightDescription {
  const FlightDescriptionModel({required super.number});

  factory FlightDescriptionModel.fromJson(Map<String, dynamic> json) {
    return FlightDescriptionModel(number: int.parse(json['number']));
  }
}
