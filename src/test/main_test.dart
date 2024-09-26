
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:catdogapp/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('Main App Initialization', () {
		testWidgets('App initializes and displays HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('HomeScreen Widget', () {
		testWidgets('Displays initial state with "Cat" text and clock icon', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time))]),
				initialState: AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => mockAnimalCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('Toggles to "Dog" text and person icon when clicked', (WidgetTester tester) async {
			final mockAnimalCubit = MockAnimalCubit();
			whenListen(
				mockAnimalCubit,
				Stream.fromIterable([
					AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
					AnimalState(animal: Animal(name: 'Dog', icon: Icons.person)),
				]),
				initialState: AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)),
			);

			await tester.pumpWidget(
				BlocProvider<AnimalCubit>(
					create: (_) => mockAnimalCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
