import 'package:flutter/material.dart';
import '../../domain/entities/payment_method.dart';

/// Payment Method Model
/// Extends the domain entity with data layer capabilities (JSON serialization)
class PaymentMethodModel extends PaymentMethod {
  const PaymentMethodModel({
    required super.id,
    required super.name,
    required super.description,
    required super.icon,
    super.isEnabled,
  });

  /// Create PaymentMethodModel from JSON
  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: _iconFromString(json['icon'] as String),
      isEnabled: json['isEnabled'] as bool? ?? true,
    );
  }

  /// Convert PaymentMethodModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': _iconToString(icon),
      'isEnabled': isEnabled,
    };
  }

  /// Helper method to convert icon code to IconData
  static IconData _iconFromString(String iconString) {
    switch (iconString) {
      case 'payment':
        return Icons.payment;
      case 'delivery_dining':
        return Icons.delivery_dining;
      case 'paypal':
        return Icons.paypal;
      case 'credit_card':
        return Icons.credit_card;
      default:
        return Icons.payment;
    }
  }

  /// Helper method to convert IconData to string
  static String _iconToString(IconData icon) {
    if (icon == Icons.payment) return 'payment';
    if (icon == Icons.delivery_dining) return 'delivery_dining';
    if (icon == Icons.paypal) return 'paypal';
    if (icon == Icons.credit_card) return 'credit_card';
    return 'payment';
  }
}
