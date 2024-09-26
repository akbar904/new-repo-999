
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catdogapp/widgets/animal_display.dart';
import 'package:catdogapp/cubits/animal_cubit.dart';
import 'package:catdogapp/models/animal.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalDisplay Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon after toggle', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([
					AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
					AnimalState(animal: Animal(name: 'Dog', icon: Icons.person)),
				]),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('triggers toggleAnimal on tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));
			
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalDisplay(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			
			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
