import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction.dart';

/// Wallet Repository Interface
/// Defines the contract for wallet operations
abstract class WalletRepository {
  /// Get current wallet balance
  Future<Either<Failure, double>> getWalletBalance();

  /// Get wallet transactions
  Future<Either<Failure, List<WalletTransaction>>> getTransactions();

  /// Add funds to wallet
  Future<Either<Failure, double>> addFunds(double amount);
}
