import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/property.dart';
import '../../domain/usecases/get_properties.dart';
import '../../domain/usecases/get_featured_properties.dart';
import '../../domain/usecases/search_properties.dart';
import '../../domain/usecases/get_properties_by_type.dart';
import '../../domain/usecases/get_property_by_id.dart';
import '../../domain/usecases/toggle_favorite.dart';
import '../../domain/usecases/get_favorite_properties.dart';
import '../../domain/usecases/is_favorite.dart';

/// Property provider using Clean Architecture use cases
/// Manages property state and delegates business logic to use cases
class PropertyProvider extends ChangeNotifier {
  final GetProperties getProperties;
  final GetFeaturedProperties getFeaturedProperties;
  final SearchProperties searchProperties;
  final GetPropertiesByType getPropertiesByType;
  final GetPropertyById getPropertyById;
  final ToggleFavorite toggleFavorite;
  final GetFavoriteProperties getFavoriteProperties;
  final IsFavorite isFavorite;

  PropertyProvider({
    required this.getProperties,
    required this.getFeaturedProperties,
    required this.searchProperties,
    required this.getPropertiesByType,
    required this.getPropertyById,
    required this.toggleFavorite,
    required this.getFavoriteProperties,
    required this.isFavorite,
  });

  // State
  List<Property> _properties = [];
  List<Property> _featuredProperties = [];
  List<Property> _favoriteProperties = [];
  Property? _selectedProperty;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Property> get properties => _properties;
  List<Property> get featuredProperties => _featuredProperties;
  List<Property> get favoriteProperties => _favoriteProperties;
  Property? get selectedProperty => _selectedProperty;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all properties
  Future<void> loadProperties() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getProperties();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (properties) {
        _properties = properties;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Load featured properties
  Future<void> loadFeaturedProperties() async {
    final result = await getFeaturedProperties();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (properties) {
        _featuredProperties = properties;
        notifyListeners();
      },
    );
  }

  /// Search properties by query
  Future<void> search(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await searchProperties(query);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (properties) {
        _properties = properties;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Get properties by type (All, Apartment, Villa, House)
  Future<void> loadPropertiesByType(String type) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getPropertiesByType(type);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (properties) {
        _properties = properties;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Load a single property by ID
  Future<void> loadPropertyById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getPropertyById(id);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _selectedProperty = null;
        _isLoading = false;
        notifyListeners();
      },
      (property) {
        _selectedProperty = property;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Toggle favorite status for a property
  Future<void> togglePropertyFavorite(String propertyId) async {
    final result = await toggleFavorite(propertyId);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (_) {
        // Reload favorite properties after toggle
        loadFavoriteProperties();
        notifyListeners();
      },
    );
  }

  /// Load all favorite properties
  Future<void> loadFavoriteProperties() async {
    final result = await getFavoriteProperties();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (properties) {
        _favoriteProperties = properties;
        notifyListeners();
      },
    );
  }

  /// Check if a property is favorited
  Future<bool> checkIsFavorite(String propertyId) async {
    final result = await isFavorite(propertyId);
    return result.fold(
      (failure) => false,
      (isFav) => isFav,
    );
  }

  /// Map failure to user-friendly error message
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is CacheFailure) {
      return 'Unable to load properties from cache.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is NotFoundFailure) {
      return 'Property not found.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
