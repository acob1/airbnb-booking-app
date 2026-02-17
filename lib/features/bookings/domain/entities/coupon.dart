import 'package:equatable/equatable.dart';

/// Coupon entity - Pure business object
class Coupon extends Equatable {
  final String id;
  final String code;
  final String description;
  final double discountPercentage;
  final double maxDiscountAmount;
  final DateTime expiryDate;
  final bool isActive;

  const Coupon({
    required this.id,
    required this.code,
    required this.description,
    required this.discountPercentage,
    required this.maxDiscountAmount,
    required this.expiryDate,
    required this.isActive,
  });

  /// Check if coupon is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);

  /// Check if coupon is valid (active and not expired)
  bool get isValid => isActive && !isExpired;

  @override
  List<Object?> get props => [
        id,
        code,
        description,
        discountPercentage,
        maxDiscountAmount,
        expiryDate,
        isActive,
      ];
}
