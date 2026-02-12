import 'package:flutter/material.dart';
import 'package:airbnb_booking_app/utils/constants.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double _balance = 2500.0;

  final List<Map<String, dynamic>> _transactions = [
    {
      'date': '22nd February, 04:10 ...',
      'type': 'Credit',
      'amount': 2500.0,
      'isCredit': true,
    },
    {
      'date': '22nd February, 12:00 ...',
      'type': 'Debit',
      'amount': 100.0,
      'isCredit': false,
    },
    {
      'date': '21st February, 03:22 PM',
      'type': 'Credit',
      'amount': 100.0,
      'isCredit': true,
    },
    {
      'date': '16th February, 12:00 ...',
      'type': 'Debit',
      'amount': 100.0,
      'isCredit': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(symbol: 'GH₵', decimalDigits: 0);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wallet',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Wallet Card
          Container(
            margin: const EdgeInsets.all(AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5B9FFF),
                  Color(0xFF4A8FFF),
                ],
              ),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Stack(
              children: [
                // Decorative circles
                Positioned(
                  right: -20,
                  top: -20,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                    ),
                  ),
                ),
                Positioned(
                  right: 60,
                  top: 20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 2),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Wallet',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Mastercard Logo
                        SizedBox(
                          width: 50,
                          height: 30,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      currencyFormat.format(_balance),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    const Text(
                      'Your current Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'History',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Transaction List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _transactions.length,
              itemBuilder: (context, index) {
                final transaction = _transactions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      // Wallet Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      // Transaction Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction['date'],
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction['type'],
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Amount
                      Text(
                        '${currencyFormat.format(transaction['amount'])} ${transaction['isCredit'] ? '+' : '-'}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: transaction['isCredit'] ? Colors.green : Colors.orange,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Add Amount Button
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    '/add-wallet',
                    arguments: _balance,
                  );
                  if (result != null && result is double) {
                    setState(() {
                      _balance = result;
                      _transactions.insert(0, {
                        'date': DateFormat('d MMMM, hh:mm a').format(DateTime.now()),
                        'type': 'Credit',
                        'amount': result - _balance,
                        'isCredit': true,
                      });
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: const Text(
                  'ADD AMOUNT',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
