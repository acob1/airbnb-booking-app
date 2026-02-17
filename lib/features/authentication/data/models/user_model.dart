import '../../domain/entities/user.dart';

/// User model - Extends entity and adds serialization
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.phoneNumber,
    super.countryCode,
    super.profileImage,
    required super.walletBalance,
    super.referralCode,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      countryCode: json['countryCode'] as String?,
      profileImage: json['profileImage'] as String?,
      walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
      referralCode: json['referralCode'] as String?,
    );
  }

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'profileImage': profileImage,
      'walletBalance': walletBalance,
      'referralCode': referralCode,
    };
  }

  /// Create UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      fullName: user.fullName,
      email: user.email,
      phoneNumber: user.phoneNumber,
      countryCode: user.countryCode,
      profileImage: user.profileImage,
      walletBalance: user.walletBalance,
      referralCode: user.referralCode,
    );
  }

  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? countryCode,
    String? profileImage,
    double? walletBalance,
    String? referralCode,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
      profileImage: profileImage ?? this.profileImage,
      walletBalance: walletBalance ?? this.walletBalance,
      referralCode: referralCode ?? this.referralCode,
    );
  }
}
