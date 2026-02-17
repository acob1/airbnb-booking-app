import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing up a new user
class SignUp {
  final AuthRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, User>> call({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  }) async {
    return await repository.signUp(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      countryCode: countryCode,
    );
  }
}
