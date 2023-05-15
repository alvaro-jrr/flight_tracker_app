import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';
import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard(this.flight, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _JunctureHeader(flight.departure)),
                const SizedBox(width: 16),
                const Icon(Icons.arrow_forward_rounded),
                const SizedBox(width: 16),
                Expanded(child: _JunctureHeader(flight.arrival)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              flight.airline.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(DateFormat.yMd('es').format(flight.date)),
          ],
        ),
      ),
    );
  }
}

class _JunctureHeader extends StatelessWidget {
  final Juncture juncture;

  const _JunctureHeader(this.juncture);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(
          juncture.iata,
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        if (juncture.airport != null)
          Text(
            juncture.airport!,
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            maxLines: 1,
          )
      ],
    );
  }
}
