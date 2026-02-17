import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Abstract interface for remote authentication data source
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String email, required String password});
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  });
  Future<void> signOut();
  Future<bool> verifyOtp({required String phoneNumber, required String otp});
  Future<void> sendOtp(String phoneNumber);
  Future<void> resetPassword({required String email, required String newPassword});
  Future<UserModel?> getCurrentUser();
  Future<bool> isSignedIn();
  Future<UserModel> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  });
}

/// Implementation of remote authentication data source
/// Stub for future API integration
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  // TODO: Inject HTTP client (e.g., Dio, http package)
  // final Dio client;
  // AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  }) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<void> signOut() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<bool> isSignedIn() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  }) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }
}
