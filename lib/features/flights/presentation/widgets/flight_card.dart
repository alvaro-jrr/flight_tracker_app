import 'package:flutter/material.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/flight.dart';
import 'package:flight_tracker_app/features/flights/presentation/widgets/widgets.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;

  const FlightCard(this.flight, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _Junctures(flight: flight),
          ],
        ),
      ),
    );
  }
}

class _Junctures extends StatelessWidget {
  const _Junctures({
    required this.flight,
  });

  final Flight flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: JunctureDescription(
            juncture: flight.departure,
            align: DescriptionAlign.left,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.grey,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: JunctureDescription(
            juncture: flight.arrival,
            align: DescriptionAlign.right,
          ),
        ),
      ],
    );
  }
}
