import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/property.dart';
import '../repositories/property_repository.dart';

/// Use case for getting a single property by ID
class GetPropertyById {
  final PropertyRepository repository;

  GetPropertyById(this.repository);

  Future<Either<Failure, Property>> call(String id) async {
    return await repository.getPropertyById(id);
  }
}
