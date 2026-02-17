import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/payment_method.dart';
import '../repositories/payment_repository.dart';

/// Get Payment Methods Use Case
/// Retrieves all available payment methods
class GetPaymentMethods {
  final PaymentRepository repository;

  GetPaymentMethods(this.repository);

  Future<Either<Failure, List<PaymentMethod>>> call() async {
    return await repository.getPaymentMethods();
  }
}
