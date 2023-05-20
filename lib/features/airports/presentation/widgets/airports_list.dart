import 'package:flutter/material.dart';

import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';
import 'package:flight_tracker_app/features/airports/presentation/widgets/widgets.dart';

class AirportsList extends StatelessWidget {
  final List<Airport> airports;

  const AirportsList(this.airports, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) => AirportCard(airports[index]),
      itemCount: airports.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}
