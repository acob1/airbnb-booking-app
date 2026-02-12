class Property {
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

  Property({
    required this.id,
    required this.name,
    required this.location,
    required this.city,
    required this.country,
    required this.price,
    this.priceType = 'night',
    this.rating = 5.0,
    required this.images,
    required this.type,
    this.isFeatured = false,
    this.isBuyable = false,
    this.maxGuests = 30,
    this.description = '',
  });

  String get fullLocation => '$city, $country';

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      city: json['city'],
      country: json['country'],
      price: json['price'].toDouble(),
      priceType: json['priceType'] ?? 'night',
      rating: json['rating']?.toDouble() ?? 5.0,
      images: List<String>.from(json['images']),
      type: json['type'],
      isFeatured: json['isFeatured'] ?? false,
      isBuyable: json['isBuyable'] ?? false,
      maxGuests: json['maxGuests'] ?? 30,
      description: json['description'] ?? '',
    );
  }

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
}
