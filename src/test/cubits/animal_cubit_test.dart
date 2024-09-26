
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.catdogapp/lib/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits AnimalState with Dog when toggleAnimal is called initially',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				isA<AnimalState>()
					..having((state) => state.animal.name, 'name', 'Dog')
					..having((state) => state.animal.icon, 'icon', Icons.person),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits AnimalState with Cat when toggleAnimal is called twice',
			build: () => animalCubit,
			act: (cubit) {
				cubit.toggleAnimal();
				cubit.toggleAnimal();
			},
			expect: () => [
				isA<AnimalState>()
					..having((state) => state.animal.name, 'name', 'Dog')
					..having((state) => state.animal.icon, 'icon', Icons.person),
				isA<AnimalState>()
					..having((state) => state.animal.name, 'name', 'Cat')
					..having((state) => state.animal.icon, 'icon', Icons.pets),
			],
		);
	});
}
