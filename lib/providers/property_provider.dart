import 'package:flutter/material.dart';
import 'package:airbnb_booking_app/models/property.dart';

class PropertyProvider extends ChangeNotifier {
  final List<Property> _properties = [
    Property(
      id: '1',
      name: 'Lavish 2 BR with Burj Khalifa',
      location: 'Dubai',
      city: 'Dubai',
      country: 'United Arab Emirates',
      price: 25000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/23555986-bedroom-6778193_1920.jpg',
        'assets/images/clickerhappy-kitchen-2165756_1920.jpg',
        'assets/images/pexels-chairs-2181968_1920.jpg',
      ],
      type: 'Apartment',
      isFeatured: true,
      description: 'Luxurious apartment with stunning views of Burj Khalifa',
    ),
    Property(
      id: '2',
      name: 'The Palace',
      location: 'Iubuskie',
      city: 'Iubuskie',
      country: 'Poland',
      price: 12000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/gregorybutler-large-home-389271_1920.jpg',
        'assets/images/justinedgecreative-home-5835289_1920.jpg',
        'assets/images/user32212-home-2486092_1920.jpg',
      ],
      type: 'Villa',
      isFeatured: true,
      description: 'Beautiful palace with historical architecture',
    ),
    Property(
      id: '3',
      name: 'The Rivolo Residences',
      location: 'Pune',
      city: 'Pune',
      country: 'India',
      price: 400000,
      priceType: 'total',
      rating: 5.0,
      images: [
        'assets/images/idat-kitchen-6914223_1920.jpg',
        'assets/images/jessebridgewater-kitchen-2400367_1920.jpg',
        'assets/images/lilitile-kitchen-9288111_1920.jpg',
      ],
      type: 'Apartment',
      isBuyable: true,
      description: 'Modern residential complex with premium amenities',
    ),
    Property(
      id: '4',
      name: 'SkyVilla',
      location: 'Pune',
      city: 'Pune',
      country: 'India',
      price: 3000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/user32212-home-2486092_1920 (1).jpg',
        'assets/images/kaboompics-tap-791172_1920.jpg',
        'assets/images/clickerhappy-kitchen-2165756_1920.jpg',
      ],
      type: 'Villa',
      description: 'Contemporary villa with garden and modern design',
    ),
    Property(
      id: '5',
      name: 'Pearl Farm',
      location: 'Pune',
      city: 'Pune',
      country: 'India',
      price: 10000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/justinedgecreative-home-5835289_1920.jpg',
        'assets/images/23555986-bedroom-6778193_1920.jpg',
        'assets/images/pexels-chairs-2181968_1920.jpg',
      ],
      type: 'House',
      description: 'Charming farmhouse with pool and outdoor space',
    ),
    Property(
      id: '6',
      name: 'Emirates Grand Hotel Apartments',
      location: 'Trade Centre',
      city: 'Dubai',
      country: 'United Arab Emirates',
      price: 60000,
      priceType: 'night',
      rating: 3.0,
      images: [
        'assets/images/lilitile-kitchen-9288111_1920.jpg',
        'assets/images/idat-kitchen-6914223_1920.jpg',
        'assets/images/kaboompics-tap-791172_1920.jpg',
      ],
      type: 'Apartment',
      description: 'Luxury hotel apartments in prime location',
    ),
    Property(
      id: '7',
      name: 'Turtle Bay HuaHin eco luxeTurt Villa',
      location: 'Khiri Khan',
      city: 'Khiri Khan',
      country: 'Thailand',
      price: 25000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/gregorybutler-large-home-389271_1920.jpg',
        'assets/images/jessebridgewater-kitchen-2400367_1920.jpg',
        'assets/images/pexels-chairs-2181968_1920.jpg',
      ],
      type: 'Villa',
      isFeatured: true,
      description: 'Eco-friendly luxury villa by the bay',
    ),
    Property(
      id: '8',
      name: 'Triple Storey 7BR+M Villa',
      location: 'Dubai',
      city: 'Dubai',
      country: 'United Arab Emirates',
      price: 25000,
      priceType: 'night',
      rating: 5.0,
      images: [
        'assets/images/user32212-home-2486092_1920.jpg',
        'assets/images/clickerhappy-kitchen-2165756_1920.jpg',
        'assets/images/23555986-bedroom-6778193_1920.jpg',
      ],
      type: 'Villa',
      isFeatured: true,
      description: 'Spacious multi-level villa with premium finishes',
    ),
  ];

  final List<String> _favoriteIds = [];

  List<Property> get properties => _properties;

  List<Property> get featuredProperties =>
      _properties.where((p) => p.isFeatured).toList();

  List<Property> getPropertiesByType(String type) {
    if (type == 'All') return _properties;
    return _properties.where((p) => p.type == type).toList();
  }

  List<Property> get favoriteProperties =>
      _properties.where((p) => _favoriteIds.contains(p.id)).toList();

  bool isFavorite(String propertyId) => _favoriteIds.contains(propertyId);

  void toggleFavorite(String propertyId) {
    if (_favoriteIds.contains(propertyId)) {
      _favoriteIds.remove(propertyId);
    } else {
      _favoriteIds.add(propertyId);
    }
    notifyListeners();
  }

  Property? getPropertyById(String id) {
    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Property> searchProperties(String query) {
    if (query.isEmpty) return _properties;

    final lowercaseQuery = query.toLowerCase();
    return _properties.where((p) {
      return p.name.toLowerCase().contains(lowercaseQuery) ||
          p.location.toLowerCase().contains(lowercaseQuery) ||
          p.city.toLowerCase().contains(lowercaseQuery) ||
          p.country.toLowerCase().contains(lowercaseQuery) ||
          p.type.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
