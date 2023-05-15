import 'package:flutter/material.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:flight_tracker_app/features/flights/presentation/pages/pages.dart';
import 'package:flight_tracker_app/injection_container.dart' as di;

void main() {
  // Inject dependencies.
  di.init();

  initializeDateFormatting('es');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flight Tracker App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      initialRoute: FlightsPage.routeName,
      routes: {
        FlightsPage.routeName: (context) => const FlightsPage(),
      },
    );
  }
}
