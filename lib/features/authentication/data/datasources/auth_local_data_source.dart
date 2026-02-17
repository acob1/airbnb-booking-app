import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

/// Abstract interface for local authentication data source
abstract class AuthLocalDataSource {
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

/// Implementation of local authentication data source
/// Contains mock authentication logic
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // Mock current user (null when signed out)
  UserModel? _currentUser;

  // Mock user database
  final Map<String, Map<String, dynamic>> _userDatabase = {
    'test@example.com': {
      'id': 'USER001',
      'fullName': 'John Doe',
      'email': 'test@example.com',
      'phoneNumber': '+1234567890',
      'password': 'password123',
      'countryCode': '+1',
      'profileImage': null,
      'walletBalance': 100.0,
      'referralCode': 'JOHN123',
    },
  };

  // Mock OTP storage (phone -> OTP)
  final Map<String, String> _otpStorage = {};

  @override
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user exists
    if (!_userDatabase.containsKey(email)) {
      throw AuthException('User not found');
    }

    final userData = _userDatabase[email]!;

    // Verify password
    if (userData['password'] != password) {
      throw AuthException('Invalid password');
    }

    // Create user model (excluding password)
    final userMap = Map<String, dynamic>.from(userData);
    userMap.remove('password');
    _currentUser = UserModel.fromJson(userMap);

    return _currentUser!;
  }

  @override
  Future<UserModel> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user already exists
    if (_userDatabase.containsKey(email)) {
      throw AuthException('User already exists with this email');
    }

    // Create new user
    final userId = 'USER${_userDatabase.length + 1}'.padLeft(7, '0');
    final referralCode = fullName.split(' ')[0].toUpperCase() +
        DateTime.now().millisecondsSinceEpoch.toString().substring(8);

    final userData = {
      'id': userId,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'countryCode': countryCode,
      'profileImage': null,
      'walletBalance': 0.0,
      'referralCode': referralCode,
    };

    _userDatabase[email] = userData;

    // Sign in the new user
    final userMap = Map<String, dynamic>.from(userData);
    userMap.remove('password');
    _currentUser = UserModel.fromJson(userMap);

    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  @override
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if OTP exists for this phone number
    if (!_otpStorage.containsKey(phoneNumber)) {
      throw AuthException('No OTP sent to this number');
    }

    // Verify OTP (or accept any 6-digit code for demo)
    final isValid = _otpStorage[phoneNumber] == otp || otp.length == 6;

    if (isValid) {
      // Clear OTP after successful verification
      _otpStorage.remove(phoneNumber);
    }

    return isValid;
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Generate a random 6-digit OTP
    final otp = (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();
    _otpStorage[phoneNumber] = otp;

    // In a real app, this would send SMS
    // For demo, we'll just print it
    print('OTP for $phoneNumber: $otp');
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Check if user exists
    if (!_userDatabase.containsKey(email)) {
      throw NotFoundException('User not found');
    }

    // Update password
    _userDatabase[email]!['password'] = newPassword;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser;
  }

  @override
  Future<bool> isSignedIn() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser != null;
  }

  @override
  Future<UserModel> updateProfile({
    required String userId,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? profileImage,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (_currentUser == null) {
      throw AuthException('No user signed in');
    }

    if (_currentUser!.id != userId) {
      throw AuthException('Invalid user ID');
    }

    // Update current user
    _currentUser = _currentUser!.copyWith(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      profileImage: profileImage,
    );

    // Update in database
    final currentEmail = _currentUser!.email;
    if (_userDatabase.containsKey(currentEmail)) {
      _userDatabase[currentEmail]!.addAll({
        if (fullName != null) 'fullName': fullName,
        if (email != null) 'email': email,
        if (phoneNumber != null) 'phoneNumber': phoneNumber,
        if (profileImage != null) 'profileImage': profileImage,
      });
    }

    return _currentUser!;
  }
}
