import '../../domain/entities/property.dart';

/// Property model - Extends entity and adds serialization
class PropertyModel extends Property {
  const PropertyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.city,
    required super.country,
    required super.price,
    required super.priceType,
    required super.rating,
    required super.images,
    required super.type,
    required super.isFeatured,
    required super.isBuyable,
    required super.maxGuests,
    required super.description,
  });

  /// Create PropertyModel from JSON
  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      price: (json['price'] as num).toDouble(),
      priceType: json['priceType'] as String? ?? 'night',
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      images: List<String>.from(json['images'] as List),
      type: json['type'] as String,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isBuyable: json['isBuyable'] as bool? ?? false,
      maxGuests: json['maxGuests'] as int? ?? 30,
      description: json['description'] as String? ?? '',
    );
  }

  /// Convert PropertyModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'city': city,
      'country': country,
      'price': price,
      'priceType': priceType,
      'rating': rating,
      'images': images,
      'type': type,
      'isFeatured': isFeatured,
      'isBuyable': isBuyable,
      'maxGuests': maxGuests,
      'description': description,
    };
  }

  /// Create PropertyModel from Property entity
  factory PropertyModel.fromEntity(Property property) {
    return PropertyModel(
      id: property.id,
      name: property.name,
      location: property.location,
      city: property.city,
      country: property.country,
      price: property.price,
      priceType: property.priceType,
      rating: property.rating,
      images: property.images,
      type: property.type,
      isFeatured: property.isFeatured,
      isBuyable: property.isBuyable,
      maxGuests: property.maxGuests,
      description: property.description,
    );
  }
}
