import '../models/wallet_transaction_model.dart';

/// Wallet Local Data Source Interface
abstract class WalletLocalDataSource {
  /// Get current wallet balance
  Future<double> getWalletBalance();

  /// Get wallet transactions
  Future<List<WalletTransactionModel>> getTransactions();

  /// Add funds to wallet
  Future<double> addFunds(double amount);
}

/// Wallet Local Data Source Implementation
/// Provides hardcoded wallet data for the app
class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  // Simulated wallet balance
  double _balance = 2500.0;

  // Hardcoded transactions
  final List<WalletTransactionModel> _transactions = [
    WalletTransactionModel(
      id: 'TXN001',
      date: DateTime(2023, 2, 22, 4, 10),
      type: 'Credit',
      amount: 2500.0,
      isCredit: true,
    ),
    WalletTransactionModel(
      id: 'TXN002',
      date: DateTime(2023, 2, 22, 12, 0),
      type: 'Debit',
      amount: 100.0,
      isCredit: false,
    ),
    WalletTransactionModel(
      id: 'TXN003',
      date: DateTime(2023, 2, 21, 15, 22),
      type: 'Credit',
      amount: 100.0,
      isCredit: true,
    ),
    WalletTransactionModel(
      id: 'TXN004',
      date: DateTime(2023, 2, 16, 12, 0),
      type: 'Debit',
      amount: 100.0,
      isCredit: false,
    ),
  ];

  @override
  Future<double> getWalletBalance() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return _balance;
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_transactions);
  }

  @override
  Future<double> addFunds(double amount) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Add new transaction
    final newTransaction = WalletTransactionModel(
      id: 'TXN${DateTime.now().millisecondsSinceEpoch}',
      date: DateTime.now(),
      type: 'Credit',
      amount: amount,
      isCredit: true,
    );

    _transactions.insert(0, newTransaction);
    _balance += amount;

    return _balance;
  }
}
