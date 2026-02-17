import 'package:flutter/material.dart';
import '../models/payment_method_model.dart';

/// Payment Local Data Source Interface
abstract class PaymentLocalDataSource {
  /// Get all payment methods
  Future<List<PaymentMethodModel>> getPaymentMethods();

  /// Process payment
  Future<void> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  });
}

/// Payment Local Data Source Implementation
/// Provides hardcoded payment methods for the app
class PaymentLocalDataSourceImpl implements PaymentLocalDataSource {
  // Hardcoded payment methods
  final List<PaymentMethodModel> _paymentMethods = const [
    PaymentMethodModel(
      id: 'Razorpay',
      name: 'Razorpay',
      description: 'Card, UPI, Net banking, Wallet(Phone Pe, Amazon Pay, Freecharge)',
      icon: Icons.payment,
      isEnabled: true,
    ),
    PaymentMethodModel(
      id: 'PayToOwner',
      name: 'Pay TO Owner',
      description: 'Pay via Cash at the time of delivery. It\'s free and only takes a few minutes',
      icon: Icons.delivery_dining,
      isEnabled: true,
    ),
    PaymentMethodModel(
      id: 'Paypal',
      name: 'Paypal',
      description: 'Credit/Debit card with Easier way to pay – online and on your mobile.',
      icon: Icons.paypal,
      isEnabled: true,
    ),
    PaymentMethodModel(
      id: 'Stripe',
      name: 'Stripe',
      description: 'Accept all major debit and credit cards from customers in every country',
      icon: Icons.credit_card,
      isEnabled: true,
    ),
  ];

  @override
  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _paymentMethods;
  }

  @override
  Future<void> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  }) async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    // In a real app, this would interact with payment gateway
    // For now, we just simulate success
    print('Processing payment:');
    print('  Method: $paymentMethodId');
    print('  Amount: \$$amount');
    print('  Booking: $bookingId');
  }
}
