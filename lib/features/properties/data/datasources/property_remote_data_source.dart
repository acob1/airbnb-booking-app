import '../../../../core/errors/exceptions.dart';
import '../models/property_model.dart';

/// Abstract interface for remote property data source
abstract class PropertyRemoteDataSource {
  Future<List<PropertyModel>> getProperties();
  Future<List<PropertyModel>> getFeaturedProperties();
  Future<List<PropertyModel>> searchProperties(String query);
  Future<List<PropertyModel>> getPropertiesByType(String type);
  Future<PropertyModel> getPropertyById(String id);
  Future<void> toggleFavorite(String propertyId);
  Future<List<PropertyModel>> getFavoriteProperties();
  Future<bool> isFavorite(String propertyId);
}

/// Implementation of remote property data source
/// Stub for future API integration
class PropertyRemoteDataSourceImpl implements PropertyRemoteDataSource {
  // TODO: Inject HTTP client (e.g., Dio, http package)
  // final Dio client;
  // PropertyRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PropertyModel>> getProperties() async {
    // TODO: Implement API call
    // Example:
    // final response = await client.get('/properties');
    // if (response.statusCode == 200) {
    //   return (response.data as List)
    //       .map((json) => PropertyModel.fromJson(json))
    //       .toList();
    // }
    // throw ServerException('Failed to load properties');

    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<PropertyModel>> getFeaturedProperties() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<PropertyModel>> searchProperties(String query) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<PropertyModel>> getPropertiesByType(String type) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<PropertyModel> getPropertyById(String id) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<void> toggleFavorite(String propertyId) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<PropertyModel>> getFavoriteProperties() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<bool> isFavorite(String propertyId) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }
}
