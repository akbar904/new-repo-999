
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/animal_cubit.dart';
import '../widgets/animal_display.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('CatDog App'),
			),
			body: BlocBuilder<AnimalCubit, AnimalState>(
				builder: (context, state) {
					return GestureDetector(
						onTap: () {
							context.read<AnimalCubit>().toggleAnimal();
						},
						child: AnimalDisplay(animal: state.animal),
					);
				},
			),
		);
	}
}
