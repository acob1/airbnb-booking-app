import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for resetting password
class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, void>> call({
    required String email,
    required String newPassword,
  }) async {
    return await repository.resetPassword(email: email, newPassword: newPassword);
  }
}
