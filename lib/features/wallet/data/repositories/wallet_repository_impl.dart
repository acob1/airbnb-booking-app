import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/wallet_transaction.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_data_source.dart';
import '../datasources/wallet_remote_data_source.dart';

/// Wallet Repository Implementation
/// Implements the domain repository interface using data sources
class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final WalletLocalDataSource localDataSource;

  WalletRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, double>> getWalletBalance() async {
    try {
      // Try remote first (when implemented)
      // For now, use local data source
      final balance = await localDataSource.getWalletBalance();
      return Right(balance);
    } on Exception {
      return const Left(CacheFailure('Failed to load wallet balance'));
    }
  }

  @override
  Future<Either<Failure, List<WalletTransaction>>> getTransactions() async {
    try {
      // Try remote first (when implemented)
      // For now, use local data source
      final transactions = await localDataSource.getTransactions();
      return Right(transactions);
    } on Exception {
      return const Left(CacheFailure('Failed to load transactions'));
    }
  }

  @override
  Future<Either<Failure, double>> addFunds(double amount) async {
    try {
      // Try remote first (when implemented)
      // For now, use local data source
      final newBalance = await localDataSource.addFunds(amount);
      return Right(newBalance);
    } on Exception {
      return const Left(ServerFailure('Failed to add funds'));
    }
  }
}
