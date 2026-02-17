import '../../domain/entities/coupon.dart';

/// Coupon model - Extends entity and adds serialization
class CouponModel extends Coupon {
  const CouponModel({
    required super.id,
    required super.code,
    required super.description,
    required super.discountPercentage,
    required super.maxDiscountAmount,
    required super.expiryDate,
    required super.isActive,
  });

  /// Create CouponModel from JSON
  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as String,
      code: json['code'] as String,
      description: json['description'] as String,
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      maxDiscountAmount: (json['maxDiscountAmount'] as num).toDouble(),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convert CouponModel to JSON
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

  /// Create CouponModel from Coupon entity
  factory CouponModel.fromEntity(Coupon coupon) {
    return CouponModel(
      id: coupon.id,
      code: coupon.code,
      description: coupon.description,
      discountPercentage: coupon.discountPercentage,
      maxDiscountAmount: coupon.maxDiscountAmount,
      expiryDate: coupon.expiryDate,
      isActive: coupon.isActive,
    );
  }
}
