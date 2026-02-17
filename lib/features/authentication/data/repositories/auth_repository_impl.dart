import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of AuthRepository
/// Coordinates between remote and local data sources
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Try remote first (when API is available)
      // For now, use local data source
      final user = await localDataSource.signIn(email: email, password: password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to sign in: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  }) async {
    try {
      final user = await localDataSource.signUp(
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        password: password,
        countryCode: countryCode,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to sign up: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await localDataSource.signOut();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to sign out: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      final isValid = await localDataSource.verifyOtp(
        phoneNumber: phoneNumber,
        otp: otp,
      );
      return Right(isValid);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to verify OTP: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp(String phoneNumber) async {
    try {
      await localDataSource.sendOtp(phoneNumber);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to send OTP: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    try {
      await localDataSource.resetPassword(email: email, newPassword: newPassword);
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to reset password: $e'));
    }
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    try {
      final user = await localDataSource.getCurrentUser();
      return Right(user);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get current user: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isSignedIn() async {
    try {
      final isSignedIn = await localDataSource.isSignedIn();
      return Right(isSignedIn);
    } catch (e) {
      return Left(UnexpectedFailure('Failed to check sign-in status: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  }) async {
    try {
      final user = await localDataSource.updateProfile(
        userId: userId,
        fullName: fullName,
        email: email,
        phoneNumber: phoneNumber,
        profileImage: profileImage,
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to update profile: $e'));
    }
  }
}
