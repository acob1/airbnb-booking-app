import 'package:equatable/equatable.dart';

/// User entity - Pure business object
class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? countryCode;
  final String? profileImage;
  final double walletBalance;
  final String? referralCode;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.countryCode,
    this.profileImage,
    required this.walletBalance,
    this.referralCode,
  });

  /// Get display name (first name)
  String get firstName {
    final parts = fullName.split(' ');
    return parts.isNotEmpty ? parts[0] : fullName;
  }

  /// Get last name
  String get lastName {
    final parts = fullName.split(' ');
    return parts.length > 1 ? parts.sublist(1).join(' ') : '';
  }

  /// Check if user has profile image
  bool get hasProfileImage => profileImage != null && profileImage!.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        phoneNumber,
        countryCode,
        profileImage,
        walletBalance,
        referralCode,
      ];
}
