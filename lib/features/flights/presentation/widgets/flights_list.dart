import 'package:flutter/material.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/flights.dart';
import 'package:flight_tracker_app/features/flights/presentation/widgets/widgets.dart';

class FlightsList extends StatelessWidget {
  final Flights flights;

  const FlightsList(this.flights, {super.key});

  @override
  Widget build(BuildContext context) {
    final data = flights.flights;

    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => FlightCard(data[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: data.length,
    );
  }
}
