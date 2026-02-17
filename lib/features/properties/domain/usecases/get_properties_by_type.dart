import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/property.dart';
import '../repositories/property_repository.dart';

/// Use case for getting properties by type
class GetPropertiesByType {
  final PropertyRepository repository;

  GetPropertiesByType(this.repository);

  Future<Either<Failure, List<Property>>> call(String type) async {
    return await repository.getPropertiesByType(type);
  }
}
