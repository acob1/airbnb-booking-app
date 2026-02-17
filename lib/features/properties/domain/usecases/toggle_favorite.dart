import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/property_repository.dart';

/// Use case for toggling favorite status
class ToggleFavorite {
  final PropertyRepository repository;

  ToggleFavorite(this.repository);

  Future<Either<Failure, void>> call(String propertyId) async {
    return await repository.toggleFavorite(propertyId);
  }
}
