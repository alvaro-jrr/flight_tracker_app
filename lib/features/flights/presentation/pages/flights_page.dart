import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flight_tracker_app/features/flights/presentation/bloc/flights_bloc.dart';
import 'package:flight_tracker_app/features/flights/presentation/widgets/widgets.dart';

class FlightsPage extends StatelessWidget {
  static const routeName = 'flights';

  const FlightsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento de Vuelos'),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const [
          FlightsSearchField(),
          SizedBox(height: 24),
          _BodyContent(),
        ],
      ),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlightsBloc, FlightsState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        }

        if (state is Error) return Text(state.message);

        if (state is Loaded) return FlightsList(state.flights);

        return const Text('No has buscado vuelos aún');
      },
    );
  }
}
