import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flight_tracker_app/features/flights/presentation/bloc/flights_bloc.dart';
import 'package:flight_tracker_app/features/flights/presentation/widgets/widgets.dart';
import 'package:flight_tracker_app/injection_container.dart' as di;

class FlightsPage extends StatelessWidget {
  static const routeName = 'flights';

  const FlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento de Vuelos'),
      ),
      body: BlocProvider(
        create: (_) => di.sl<FlightsBloc>(),
        child: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const [
          Text(
            'Busca cualquier vuelo a nivel mundial y conoce su estatus actual.',
          ),
          SizedBox(height: 24),
          FlightsSearchField(),
        ],
      ),
    );
  }
}
