
import 'package:flutter/material.dart';

class Animal {
	final String name;
	final IconData icon;

	Animal({required this.name, required this.icon});

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'icon': icon.toString(),
		};
	}

	factory Animal.fromJson(Map<String, dynamic> json) {
		return Animal(
			name: json['name'],
			icon: _iconFromString(json['icon']),
		);
	}

	static IconData _iconFromString(String iconString) {
		switch (iconString) {
			case 'IconData(U+0E91B)':
				return Icons.pets;
			case 'IconData(U+0E491)':
				return Icons.person;
			default:
				throw ArgumentError('Unknown icon string: $iconString');
		}
	}
}
