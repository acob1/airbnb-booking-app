import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/property.dart';
import '../repositories/property_repository.dart';

/// Use case for searching properties
class SearchProperties {
  final PropertyRepository repository;

  SearchProperties(this.repository);

  Future<Either<Failure, List<Property>>> call(String query) async {
    return await repository.searchProperties(query);
  }
}
