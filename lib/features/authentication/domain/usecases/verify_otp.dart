import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for verifying OTP
class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<Either<Failure, bool>> call({
    required String phoneNumber,
    required String otp,
  }) async {
    return await repository.verifyOtp(phoneNumber: phoneNumber, otp: otp);
  }
}
