import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/property.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_data_source.dart';
import '../datasources/property_remote_data_source.dart';

/// Implementation of PropertyRepository
/// Coordinates between remote and local data sources
class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyRemoteDataSource remoteDataSource;
  final PropertyLocalDataSource localDataSource;

  PropertyRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Property>>> getProperties() async {
    try {
      // Try remote first (when API is available)
      // For now, use local data source
      final properties = await localDataSource.getProperties();
      return Right(properties);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get properties: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Property>>> getFeaturedProperties() async {
    try {
      final properties = await localDataSource.getFeaturedProperties();
      return Right(properties);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get featured properties: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Property>>> searchProperties(String query) async {
    try {
      final properties = await localDataSource.searchProperties(query);
      return Right(properties);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to search properties: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Property>>> getPropertiesByType(String type) async {
    try {
      final properties = await localDataSource.getPropertiesByType(type);
      return Right(properties);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get properties by type: $e'));
    }
  }

  @override
  Future<Either<Failure, Property>> getPropertyById(String id) async {
    try {
      final property = await localDataSource.getPropertyById(id);
      return Right(property);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get property: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String propertyId) async {
    try {
      await localDataSource.toggleFavorite(propertyId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to toggle favorite: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Property>>> getFavoriteProperties() async {
    try {
      final properties = await localDataSource.getFavoriteProperties();
      return Right(properties);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get favorite properties: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String propertyId) async {
    try {
      final isFav = await localDataSource.isFavorite(propertyId);
      return Right(isFav);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to check favorite status: $e'));
    }
  }
}
