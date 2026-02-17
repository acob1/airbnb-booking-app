import 'package:equatable/equatable.dart';

/// Property entity - Pure business object with no external dependencies
class Property extends Equatable {
  final String id;
  final String name;
  final String location;
  final String city;
  final String country;
  final double price;
  final String priceType; // 'night' or 'total'
  final double rating;
  final List<String> images;
  final String type; // 'Apartment', 'Villa', 'House'
  final bool isFeatured;
  final bool isBuyable;
  final int maxGuests;
  final String description;

  const Property({
    required this.id,
    required this.name,
    required this.location,
    required this.city,
    required this.country,
    required this.price,
    required this.priceType,
    required this.rating,
    required this.images,
    required this.type,
    required this.isFeatured,
    required this.isBuyable,
    required this.maxGuests,
    required this.description,
  });

  /// Get full location string
  String get fullLocation => '$city, $country';

  @override
  List<Object?> get props => [
        id,
        name,
        location,
        city,
        country,
        price,
        priceType,
        rating,
        images,
        type,
        isFeatured,
        isBuyable,
        maxGuests,
        description,
      ];
}
