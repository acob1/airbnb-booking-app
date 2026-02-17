import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/payment_method.dart';

/// Payment Repository Interface
/// Defines the contract for payment operations
abstract class PaymentRepository {
  /// Get all available payment methods
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods();

  /// Process a payment with the selected method
  Future<Either<Failure, void>> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  });
}
