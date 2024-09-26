
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../models/animal.dart';

class AnimalState {
	final Animal animal;

	AnimalState(this.animal);
}

class AnimalCubit extends Cubit<AnimalState> {
	AnimalCubit() : super(AnimalState(Animal(name: 'Cat', icon: Icons.pets)));

	void toggleAnimal() {
		final currentAnimal = state.animal.name;
		if (currentAnimal == 'Cat') {
			emit(AnimalState(Animal(name: 'Dog', icon: Icons.person)));
		} else {
			emit(AnimalState(Animal(name: 'Cat', icon: Icons.pets)));
		}
	}
}
