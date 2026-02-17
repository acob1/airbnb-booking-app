import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/property_repository.dart';

/// Use case for checking if a property is favorited
class IsFavorite {
  final PropertyRepository repository;

  IsFavorite(this.repository);

  Future<Either<Failure, bool>> call(String propertyId) async {
    return await repository.isFavorite(propertyId);
  }
}
