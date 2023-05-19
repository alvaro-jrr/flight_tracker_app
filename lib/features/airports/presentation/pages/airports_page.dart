import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flight_tracker_app/features/airports/presentation/bloc/airports_bloc.dart';
import 'package:flight_tracker_app/features/airports/presentation/widgets/widgets.dart';
import 'package:flight_tracker_app/injection_container.dart' as di;

class AirportsPage extends StatelessWidget {
  static const routeName = 'airports';

  const AirportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        scrolledUnderElevation: 0,
        title: const Text(
          'Búsqueda de Aeropuertos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) => di.sl<AirportsBloc>(),
        child: const _Body(),
      ),
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
          AirportsSearchField(),
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
    return BlocBuilder<AirportsBloc, AirportsState>(
      builder: (context, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        }

        if (state is Error) return Text(state.message);

        if (state is Loaded) return AirportsList(state.airports);

        return const Text('No has buscado aeropuertos aún');
      },
    );
  }
}
