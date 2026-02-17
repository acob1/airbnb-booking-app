import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/usecases/get_payment_methods.dart';
import '../../domain/usecases/process_payment.dart';

/// Payment Provider
/// Manages payment state and operations in the presentation layer
class PaymentProvider extends ChangeNotifier {
  final GetPaymentMethods getPaymentMethods;
  final ProcessPayment processPayment;

  PaymentProvider({
    required this.getPaymentMethods,
    required this.processPayment,
  });

  // State variables
  List<PaymentMethod> _paymentMethods = [];
  String? _selectedMethodId;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isProcessingPayment = false;

  // Getters
  List<PaymentMethod> get paymentMethods => _paymentMethods;
  String? get selectedMethodId => _selectedMethodId;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isProcessingPayment => _isProcessingPayment;

  PaymentMethod? get selectedMethod {
    if (_selectedMethodId == null) return null;
    try {
      return _paymentMethods.firstWhere((method) => method.id == _selectedMethodId);
    } catch (e) {
      return null;
    }
  }

  /// Load available payment methods
  Future<void> loadPaymentMethods() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getPaymentMethods();

    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _paymentMethods = [];
      },
      (methods) {
        _paymentMethods = methods;
        _errorMessage = null;

        // Auto-select first method if none selected
        if (_selectedMethodId == null && methods.isNotEmpty) {
          _selectedMethodId = methods.first.id;
        }
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Select a payment method
  void selectPaymentMethod(String methodId) {
    _selectedMethodId = methodId;
    _errorMessage = null;
    notifyListeners();
  }

  /// Process payment with selected method
  Future<bool> processPaymentWithSelectedMethod({
    required double amount,
    required String bookingId,
  }) async {
    if (_selectedMethodId == null) {
      _errorMessage = 'Please select a payment method';
      notifyListeners();
      return false;
    }

    _isProcessingPayment = true;
    _errorMessage = null;
    notifyListeners();

    final result = await processPayment(
      paymentMethodId: _selectedMethodId!,
      amount: amount,
      bookingId: bookingId,
    );

    _isProcessingPayment = false;

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
        return false;
      },
      (_) {
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset provider state
  void reset() {
    _selectedMethodId = null;
    _errorMessage = null;
    _isProcessingPayment = false;
    notifyListeners();
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred';
  }
}
