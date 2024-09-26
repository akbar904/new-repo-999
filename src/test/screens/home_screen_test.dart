
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:catdogapp/screens/home_screen.dart';

// Define a mock Cubit
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('HomeScreen', () {
		late MockAnimalCubit mockAnimalCubit;

		setUp(() {
			mockAnimalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat text with clock icon initially', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog text with person icon after tapping', (WidgetTester tester) async {
			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Cat', icon: Icons.access_time)));
			
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>.value(
						value: mockAnimalCubit,
						child: HomeScreen(),
					),
				),
			);

			// Simulate tapping the text
			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			when(() => mockAnimalCubit.state).thenReturn(AnimalState(animal: Animal(name: 'Dog', icon: Icons.person)));

			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
