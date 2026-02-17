import '../../domain/entities/wallet_transaction.dart';

/// Wallet Transaction Model
/// Extends the domain entity with data layer capabilities (JSON serialization)
class WalletTransactionModel extends WalletTransaction {
  const WalletTransactionModel({
    required super.id,
    required super.date,
    required super.type,
    required super.amount,
    required super.isCredit,
  });

  /// Create WalletTransactionModel from JSON
  factory WalletTransactionModel.fromJson(Map<String, dynamic> json) {
    return WalletTransactionModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      type: json['type'] as String,
      amount: (json['amount'] as num).toDouble(),
      isCredit: json['isCredit'] as bool,
    );
  }

  /// Convert WalletTransactionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type,
      'amount': amount,
      'isCredit': isCredit,
    };
  }
}
