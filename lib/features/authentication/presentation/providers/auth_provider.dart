import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/sign_in.dart';
import '../../domain/usecases/sign_up.dart';
import '../../domain/usecases/sign_out.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/is_signed_in.dart';

/// Authentication provider using Clean Architecture use cases
/// Manages authentication state and delegates business logic to use cases
class AuthProvider extends ChangeNotifier {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final VerifyOtp verifyOtp;
  final SendOtp sendOtp;
  final ResetPassword resetPassword;
  final GetCurrentUser getCurrentUser;
  final IsSignedIn isSignedIn;

  AuthProvider({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.verifyOtp,
    required this.sendOtp,
    required this.resetPassword,
    required this.getCurrentUser,
    required this.isSignedIn,
  });

  // State
  User? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  /// Initialize auth state (check if user is signed in)
  Future<void> initialize() async {
    final result = await isSignedIn();
    result.fold(
      (failure) => _isAuthenticated = false,
      (signedIn) => _isAuthenticated = signedIn,
    );

    if (_isAuthenticated) {
      await loadCurrentUser();
    }

    notifyListeners();
  }

  /// Load current user
  Future<void> loadCurrentUser() async {
    final result = await getCurrentUser();
    result.fold(
      (failure) {
        _currentUser = null;
        _isAuthenticated = false;
      },
      (user) {
        _currentUser = user;
        _isAuthenticated = user != null;
      },
    );
    notifyListeners();
  }

  /// Sign in user
  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await signIn(email: email, password: password);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        _isAuthenticated = false;
        notifyListeners();
        return false;
      },
      (user) {
        _currentUser = user;
        _isAuthenticated = true;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Sign up new user
  Future<bool> signUpUser({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    String? countryCode,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await signUp(
      fullName: fullName,
      email: email,
      phoneNumber: phoneNumber,
      password: password,
      countryCode: countryCode,
    );

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        _isAuthenticated = false;
        notifyListeners();
        return false;
      },
      (user) {
        _currentUser = user;
        _isAuthenticated = true;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Sign out current user
  Future<bool> signOutUser() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await signOut();

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _currentUser = null;
        _isAuthenticated = false;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Verify OTP
  Future<bool> verifyOtpCode({
    required String phoneNumber,
    required String otp,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await verifyOtp(phoneNumber: phoneNumber, otp: otp);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (isValid) {
        _isLoading = false;
        _errorMessage = isValid ? null : 'Invalid OTP';
        notifyListeners();
        return isValid;
      },
    );
  }

  /// Send OTP
  Future<bool> sendOtpCode(String phoneNumber) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await sendOtp(phoneNumber);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Reset password
  Future<bool> resetUserPassword({
    required String email,
    required String newPassword,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await resetPassword(email: email, newPassword: newPassword);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Map failure to user-friendly error message
  String _mapFailureToMessage(Failure failure) {
    if (failure is AuthFailure) {
      return failure.message;
    } else if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is NotFoundFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
