import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flight_tracker_app/features/airports/domain/entities/airport.dart';

class AirportLocationPage extends StatefulWidget {
  static const routeName = 'airport-location';

  const AirportLocationPage({super.key});

  @override
  State<AirportLocationPage> createState() => _AirportLocationPageState();
}

class _AirportLocationPageState extends State<AirportLocationPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final airport = ModalRoute.of(context)!.settings.arguments as Airport;

    final position = LatLng(
      airport.latitude,
      airport.longitude,
    );

    final initialPosition = CameraPosition(
      target: position,
      zoom: 16,
      tilt: 32,
    );

    final markers = <Marker>{};

    // Add marker in the initial position.
    markers.add(Marker(
      markerId: const MarkerId("geo-location"),
      position: position,
    ));

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Ubicación'),
        actions: [
          IconButton(
            onPressed: () async {
              final GoogleMapController controller = await _controller.future;

              // Moves camera back to initial position.
              controller.animateCamera(CameraUpdate.newLatLng(position));
            },
            icon: const Icon(Icons.gps_not_fixed),
            tooltip: 'Volver a posición inicial',
          )
        ],
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPosition,
        markers: markers,
        onMapCreated: (controller) => _controller.complete(controller),
      ),
    );
  }
}
