import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

/// Authentication repository interface
/// Defines the contract for authentication operations
abstract class AuthRepository {
  /// Sign in with email and password
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  });

  /// Sign up with user details
  Future<Either<Failure, User>> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  });

  /// Sign out current user
  Future<Either<Failure, void>> signOut();

  /// Verify OTP code
  Future<Either<Failure, bool>> verifyOtp({
    required String phoneNumber,
    required String otp,
  });

  /// Send OTP to phone number
  Future<Either<Failure, void>> sendOtp(String phoneNumber);

  /// Reset password
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  });

  /// Get current user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Check if user is signed in
  Future<Either<Failure, bool>> isSignedIn();

  /// Update user profile
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  });
}
