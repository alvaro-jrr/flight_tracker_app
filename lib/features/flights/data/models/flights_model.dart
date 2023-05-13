import 'package:flight_tracker_app/features/flights/data/models/flight_model.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';

class FlightsModel extends Flights {
  const FlightsModel({required super.flights});

  factory FlightsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonFlights = json['data'];

    return FlightsModel(
      flights: jsonFlights.map((jsonFlight) {
        return FlightModel.fromJson(jsonFlight);
      }).toList(),
    );
  }
}
