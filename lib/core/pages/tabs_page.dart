import 'package:flutter/material.dart';

import 'package:flight_tracker_app/features/airports/presentation/pages/pages.dart';
import 'package:flight_tracker_app/features/flights/presentation/pages/pages.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final pageController = PageController();
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.flight_takeoff),
            label: 'Vuelos',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_airport),
            label: 'Aeropuertos',
          ),
        ],
        selectedIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;

            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
            );
          });
        },
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          FlightsPage(),
          AirportsPage(),
        ],
      ),
    );
  }
}
