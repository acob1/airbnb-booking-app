import '../models/wallet_transaction_model.dart';

/// Wallet Remote Data Source Interface
abstract class WalletRemoteDataSource {
  /// Get wallet balance from API
  Future<double> getWalletBalance();

  /// Get transactions from API
  Future<List<WalletTransactionModel>> getTransactions();

  /// Add funds via API
  Future<double> addFunds(double amount);
}

/// Wallet Remote Data Source Implementation
/// Stub for future API integration
class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  @override
  Future<double> getWalletBalance() async {
    // TODO: Implement API call to get wallet balance
    throw UnimplementedError('API not yet integrated');
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions() async {
    // TODO: Implement API call to get transactions
    throw UnimplementedError('API not yet integrated');
  }

  @override
  Future<double> addFunds(double amount) async {
    // TODO: Implement API call to add funds
    throw UnimplementedError('API not yet integrated');
  }
}
