import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flight_tracker_app/features/airports/presentation/bloc/airports_bloc.dart';

class AirportsSearchField extends StatefulWidget {
  const AirportsSearchField({super.key});

  @override
  State<AirportsSearchField> createState() => _AirportsSearchFieldState();
}

class _AirportsSearchFieldState extends State<AirportsSearchField> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (value) => inputStr = value,
      onSubmitted: (_) => addConcrete(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: 'Código de País',
        hintText: 'ej: VE, US, CO',
        suffixIcon: const Icon(Icons.search),
      ),
    );
  }

  void addConcrete() {
    // Clear field.
    controller.clear();

    BlocProvider.of<AirportsBloc>(context).add(
      GetAirportsFromConcreteCountryCode(inputStr),
    );

    // Clear value.
    inputStr = '';
  }
}
