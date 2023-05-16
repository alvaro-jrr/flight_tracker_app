import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:flight_tracker_app/features/flights/domain/entities/juncture.dart';

enum DescriptionAlign { left, right }

class JunctureDescription extends StatelessWidget {
  final Juncture juncture;
  final DescriptionAlign align;

  const JunctureDescription({
    super.key,
    required this.juncture,
    required this.align,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const verticalSpacing = 6.0;

    // Set up alignment.
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start;
    TextAlign textAlign = TextAlign.left;

    // Set the plane icon.
    IconData icon = Icons.flight_takeoff;

    if (align == DescriptionAlign.right) {
      mainAxisAlignment = MainAxisAlignment.end;
      crossAxisAlignment = CrossAxisAlignment.end;
      textAlign = TextAlign.right;
      icon = Icons.flight_land;
    }

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              DateFormat.yMMMd('es').format(juncture.estimated),
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
        const SizedBox(height: verticalSpacing),
        if (juncture.airport != null)
          Text(
            juncture.airport!,
            textAlign: textAlign,
            overflow: TextOverflow.clip,
            maxLines: 1,
          ),
        const SizedBox(height: verticalSpacing),
        Text(
          juncture.iata,
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: verticalSpacing),
        Text(
          DateFormat.Hm().format(juncture.estimated),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
