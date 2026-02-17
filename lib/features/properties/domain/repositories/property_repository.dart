import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/property.dart';

/// Property repository interface
/// Defines the contract for property data operations
abstract class PropertyRepository {
  /// Get all properties
  Future<Either<Failure, List<Property>>> getProperties();

  /// Get featured properties only
  Future<Either<Failure, List<Property>>> getFeaturedProperties();

  /// Search properties by query string
  Future<Either<Failure, List<Property>>> searchProperties(String query);

  /// Get properties by type (All, Apartment, Villa, House)
  Future<Either<Failure, List<Property>>> getPropertiesByType(String type);

  /// Get a single property by ID
  Future<Either<Failure, Property>> getPropertyById(String id);

  /// Toggle favorite status for a property
  Future<Either<Failure, void>> toggleFavorite(String propertyId);

  /// Get all favorite properties
  Future<Either<Failure, List<Property>>> getFavoriteProperties();

  /// Check if a property is favorited
  Future<Either<Failure, bool>> isFavorite(String propertyId);
}
