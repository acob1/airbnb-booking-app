import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/wallet_repository.dart';

/// Get Wallet Balance Use Case
/// Retrieves the current wallet balance
class GetWalletBalance {
  final WalletRepository repository;

  GetWalletBalance(this.repository);

  Future<Either<Failure, double>> call() async {
    return await repository.getWalletBalance();
  }
}
