import 'package:flutter/material.dart';

import 'package:circle_flags/circle_flags.dart';

import 'package:flight_tracker_app/core/widgets/widgets.dart';
import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

class AirportCard extends StatelessWidget {
  final Airport airport;

  const AirportCard(this.airport, {super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final secondaryColor = Theme.of(context).colorScheme.secondary;

    return OutlinedCard(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_airport_outlined,
                        color: primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          airport.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CircleFlag(
                  airport.country,
                  size: 32,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: secondaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  airport.region,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: secondaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
