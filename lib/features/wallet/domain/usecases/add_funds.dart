import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/wallet_repository.dart';

/// Add Funds Use Case
/// Adds funds to the wallet and returns new balance
class AddFunds {
  final WalletRepository repository;

  AddFunds(this.repository);

  Future<Either<Failure, double>> call(double amount) async {
    if (amount <= 0) {
      return const Left(ValidationFailure('Amount must be greater than 0'));
    }
    return await repository.addFunds(amount);
  }
}
