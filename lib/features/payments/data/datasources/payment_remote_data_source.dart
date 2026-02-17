import '../models/payment_method_model.dart';

/// Payment Remote Data Source Interface
abstract class PaymentRemoteDataSource {
  /// Get payment methods from API
  Future<List<PaymentMethodModel>> getPaymentMethods();

  /// Process payment via API
  Future<void> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  });
}

/// Payment Remote Data Source Implementation
/// Stub for future API integration
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    // TODO: Implement API call to get payment methods
    throw UnimplementedError('API not yet integrated');
  }

  @override
  Future<void> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  }) async {
    // TODO: Implement API call to process payment
    throw UnimplementedError('API not yet integrated');
  }
}
