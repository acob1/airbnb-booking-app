class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? countryCode;
  final String? profileImage;
  final double walletBalance;
  final String? referralCode;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.countryCode,
    this.profileImage,
    this.walletBalance = 0.0,
    this.referralCode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
      profileImage: json['profileImage'],
      walletBalance: json['walletBalance']?.toDouble() ?? 0.0,
      referralCode: json['referralCode'],
    );
  }

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
}
