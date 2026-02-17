import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/wallet_transaction.dart';
import '../repositories/wallet_repository.dart';

/// Get Transactions Use Case
/// Retrieves wallet transaction history
class GetTransactions {
  final WalletRepository repository;

  GetTransactions(this.repository);

  Future<Either<Failure, List<WalletTransaction>>> call() async {
    return await repository.getTransactions();
  }
}
