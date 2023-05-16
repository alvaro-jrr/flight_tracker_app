import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flight_tracker_app/features/flights/presentation/bloc/flights_bloc.dart';

class FlightsSearchField extends StatefulWidget {
  const FlightsSearchField({super.key});

  @override
  State<FlightsSearchField> createState() => _FlightsSearchFieldState();
}

class _FlightsSearchFieldState extends State<FlightsSearchField> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      onChanged: (value) => inputStr = value,
      onSubmitted: (_) => addConcrete(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: 'Número de Vuelo',
        hintText: 'ej: 250, 100, 701',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  void addConcrete() {
    // Clear field.
    controller.clear();

    BlocProvider.of<FlightsBloc>(context).add(
      GetFlightsFromConcreteFlightNumber(inputStr),
    );

    // Clear value.
    inputStr = '';
  }
}
