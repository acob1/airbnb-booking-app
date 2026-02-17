import 'package:equatable/equatable.dart';

/// Wallet Transaction Entity
/// Represents a wallet transaction in the domain layer
class WalletTransaction extends Equatable {
  final String id;
  final DateTime date;
  final String type;
  final double amount;
  final bool isCredit;

  const WalletTransaction({
    required this.id,
    required this.date,
    required this.type,
    required this.amount,
    required this.isCredit,
  });

  @override
  List<Object?> get props => [id, date, type, amount, isCredit];
}
