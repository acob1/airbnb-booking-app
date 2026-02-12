class Coupon {
  final String id;
  final String code;
  final String description;
  final double discountPercentage;
  final double maxDiscountAmount;
  final DateTime expiryDate;
  final bool isActive;

  Coupon({
    required this.id,
    required this.code,
    required this.description,
    required this.discountPercentage,
    required this.maxDiscountAmount,
    required this.expiryDate,
    this.isActive = true,
  });

  bool get isExpired => DateTime.now().isAfter(expiryDate);

  bool get isValid => isActive && !isExpired;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      code: json['code'],
      description: json['description'],
      discountPercentage: json['discountPercentage'].toDouble(),
      maxDiscountAmount: json['maxDiscountAmount'].toDouble(),
      expiryDate: DateTime.parse(json['expiryDate']),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'discountPercentage': discountPercentage,
      'maxDiscountAmount': maxDiscountAmount,
      'expiryDate': expiryDate.toIso8601String(),
      'isActive': isActive,
    };
  }
}
