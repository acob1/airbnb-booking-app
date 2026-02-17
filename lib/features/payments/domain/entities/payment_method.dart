import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Payment Method Entity
/// Represents a payment method option in the domain layer
class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final bool isEnabled;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isEnabled = true,
  });

  @override
  List<Object?> get props => [id, name, description, icon, isEnabled];
}
