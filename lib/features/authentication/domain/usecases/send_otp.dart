import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

/// Use case for sending OTP to phone number
class SendOtp {
  final AuthRepository repository;

  SendOtp(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber) async {
    return await repository.sendOtp(phoneNumber);
  }
}
