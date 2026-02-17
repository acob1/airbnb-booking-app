import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/usecases/get_wallet_balance.dart';
import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/add_funds.dart';

/// Wallet Provider
/// Manages wallet state and operations in the presentation layer
class WalletProvider extends ChangeNotifier {
  final GetWalletBalance getWalletBalance;
  final GetTransactions getTransactions;
  final AddFunds addFunds;

  WalletProvider({
    required this.getWalletBalance,
    required this.getTransactions,
    required this.addFunds,
  });

  // State variables
  double _balance = 0.0;
  List<WalletTransaction> _transactions = [];
  bool _isLoading = false;
  bool _isAddingFunds = false;
  String? _errorMessage;

  // Getters
  double get balance => _balance;
  List<WalletTransaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  bool get isAddingFunds => _isAddingFunds;
  String? get errorMessage => _errorMessage;

  /// Load wallet balance
  Future<void> loadBalance() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getWalletBalance();

    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _balance = 0.0;
      },
      (balance) {
        _balance = balance;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Load wallet transactions
  Future<void> loadTransactions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getTransactions();

    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _transactions = [];
      },
      (transactions) {
        _transactions = transactions;
        _errorMessage = null;
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  /// Load both balance and transactions
  Future<void> loadWalletData() async {
    await Future.wait([
      loadBalance(),
      loadTransactions(),
    ]);
  }

  /// Add funds to wallet
  Future<bool> addFundsToWallet(double amount) async {
    _isAddingFunds = true;
    _errorMessage = null;
    notifyListeners();

    final result = await addFunds(amount);

    _isAddingFunds = false;

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
        return false;
      },
      (newBalance) {
        _balance = newBalance;
        _errorMessage = null;
        // Reload transactions to show the new transaction
        loadTransactions();
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

  /// Map failure to user-friendly message
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is CacheFailure) {
      return failure.message;
    } else if (failure is ValidationFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred';
  }
}
