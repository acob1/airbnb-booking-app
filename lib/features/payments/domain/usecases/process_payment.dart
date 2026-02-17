import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/payment_repository.dart';

/// Process Payment Use Case
/// Processes a payment transaction
class ProcessPayment {
  final PaymentRepository repository;

  ProcessPayment(this.repository);

  Future<Either<Failure, void>> call({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  }) async {
    return await repository.processPayment(
      paymentMethodId: paymentMethodId,
      amount: amount,
      bookingId: bookingId,
    );
  }
}
