import '../../../../core/errors/exceptions.dart';
import '../models/property_model.dart';

/// Abstract interface for local property data source
abstract class PropertyLocalDataSource {
  Future<List<PropertyModel>> getProperties();
  Future<List<PropertyModel>> getFeaturedProperties();
  Future<List<PropertyModel>> searchProperties(String query);
  Future<List<PropertyModel>> getPropertiesByType(String type);
  Future<PropertyModel> getPropertyById(String id);
  Future<void> toggleFavorite(String propertyId);
  Future<List<PropertyModel>> getFavoriteProperties();
  Future<bool> isFavorite(String propertyId);
}

/// Implementation of local property data source
/// Contains hardcoded property data (will be replaced with actual cache/database in future)
class PropertyLocalDataSourceImpl implements PropertyLocalDataSource {
  // Store favorite property IDs
  final Set<String> _favoriteIds = {};

  // Hardcoded properties (moved from PropertyProvider)
  final List<PropertyModel> _properties = const [
    PropertyModel(
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
      isBuyable: false,
      maxGuests: 30,
      description: 'Luxurious apartment with stunning views of Burj Khalifa',
    ),
    PropertyModel(
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
      isBuyable: false,
      maxGuests: 30,
      description: 'Beautiful palace with historical architecture',
    ),
    PropertyModel(
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
      isFeatured: false,
      isBuyable: true,
      maxGuests: 30,
      description: 'Modern residential complex with premium amenities',
    ),
    PropertyModel(
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
      isFeatured: false,
      isBuyable: false,
      maxGuests: 30,
      description: 'Contemporary villa with garden and modern design',
    ),
    PropertyModel(
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
      isFeatured: false,
      isBuyable: false,
      maxGuests: 30,
      description: 'Charming farmhouse with pool and outdoor space',
    ),
    PropertyModel(
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
      isFeatured: false,
      isBuyable: false,
      maxGuests: 30,
      description: 'Luxury hotel apartments in prime location',
    ),
    PropertyModel(
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
      isBuyable: false,
      maxGuests: 30,
      description: 'Eco-friendly luxury villa by the bay',
    ),
    PropertyModel(
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
      isBuyable: false,
      maxGuests: 30,
      description: 'Spacious multi-level villa with premium finishes',
    ),
  ];

  @override
  Future<List<PropertyModel>> getProperties() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _properties;
  }

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _properties.where((p) => p.isFeatured).toList();
  }

  @override
  Future<List<PropertyModel>> searchProperties(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));

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

  @override
  Future<List<PropertyModel>> getPropertiesByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (type == 'All') return _properties;
    return _properties.where((p) => p.type == type).toList();
  }

  @override
  Future<PropertyModel> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _properties.firstWhere((p) => p.id == id);
    } catch (e) {
      throw NotFoundException('Property with id $id not found');
    }
  }

  @override
  Future<void> toggleFavorite(String propertyId) async {
    await Future.delayed(const Duration(milliseconds: 100));

    if (_favoriteIds.contains(propertyId)) {
      _favoriteIds.remove(propertyId);
    } else {
      _favoriteIds.add(propertyId);
    }
  }

  @override
  Future<List<PropertyModel>> getFavoriteProperties() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _properties.where((p) => _favoriteIds.contains(p.id)).toList();
  }

  @override
  Future<bool> isFavorite(String propertyId) async {
    return _favoriteIds.contains(propertyId);
  }
}
