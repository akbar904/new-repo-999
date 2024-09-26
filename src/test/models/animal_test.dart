
import 'package:flutter_test/flutter_test.dart';
import 'package:catdogapp/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have correct properties', () {
			final animal = Animal(name: 'Cat', icon: Icons.pets);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});

		test('Animal model should correctly serialize to JSON', () {
			final animal = Animal(name: 'Dog', icon: Icons.person);
			final json = animal.toJson();

			expect(json['name'], 'Dog');
			expect(json['icon'], Icons.person.toString());
		});

		test('Animal model should correctly deserialize from JSON', () {
			final json = {'name': 'Cat', 'icon': Icons.pets.toString()};
			final animal = Animal.fromJson(json);

			expect(animal.name, 'Cat');
			expect(animal.icon, Icons.pets);
		});
	});
}
