import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/property.dart';
import '../repositories/property_repository.dart';

/// Use case for getting featured properties only
class GetFeaturedProperties {
  final PropertyRepository repository;

  GetFeaturedProperties(this.repository);

  Future<Either<Failure, List<Property>>> call() async {
    return await repository.getFeaturedProperties();
  }
}
