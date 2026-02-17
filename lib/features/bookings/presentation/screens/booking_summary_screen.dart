import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../properties/domain/entities/property.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  bool _useWallet = false;
  final double _walletBalance = 100.0;

  void _handleContinue() {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};

    Navigator.pushNamed(
      context,
      '/payment-method',
      arguments: {
        ...args,
        'useWallet': _useWallet,
      },
    );
  }

  void _showCoupons() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Coupons', style: AppTextStyles.heading3),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Available coupons',
                style: AppTextStyles.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              _buildCouponItem(
                '50% off up to \$100 | ...',
                '2024-02-29',
                onUse: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coupon applied!')),
                  );
                },
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildCouponItem(
                '60% off up to \$120 | U...',
                '2025-02-28',
                onUse: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Coupon applied!')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCouponItem(String title, String expiry, {required VoidCallback onUse}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer_outlined, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(expiry, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          TextButton(
            onPressed: onUse,
            child: const Text('Use', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {};
    final property = args['property'] as Property?;
    final checkIn = args['checkIn'] as DateTime?;
    final checkOut = args['checkOut'] as DateTime?;
    final numberOfGuests = args['numberOfGuests'] as int? ?? 1;

    final dateFormat = DateFormat('dd/MM/yyyy');
    final currencyFormat = NumberFormat.currency(symbol: 'GH₵', decimalDigits: 1);

    // Calculate booking details
    final numberOfDays = checkOut != null && checkIn != null
        ? checkOut.difference(checkIn).inDays
        : 0;
    final amount = (property?.price ?? 25000) * numberOfDays;
    const tax = 5.0;
    final discount = _useWallet ? _walletBalance : 0.0;
    final total = amount + tax - discount;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Info
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      color: AppColors.border,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: property?.images.isNotEmpty == true
                          ? Image.asset(
                              property!.images.first,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.home, size: 30, color: AppColors.textSecondary),
                                );
                              },
                            )
                          : const Center(
                              child: Icon(Icons.home, size: 30, color: AppColors.textSecondary),
                            ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, size: 16, color: AppColors.star),
                            const SizedBox(width: 4),
                            Text(
                              '${property?.rating ?? 5}',
                              style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property?.name ?? 'Triple Storey 7BR+M Villa',
                          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          property?.fullLocation ?? 'Dubai, United Arab Emirates',
                          style: AppTextStyles.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${currencyFormat.format(property?.price ?? 25000)} /night',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Booking Details
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  _buildDetailRow('Booking Date', dateFormat.format(DateTime.now())),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDetailRow('Check in', checkIn != null ? dateFormat.format(checkIn) : '-'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDetailRow('Check out', checkOut != null ? dateFormat.format(checkOut) : '-'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDetailRow('Number of Guest', numberOfGuests.toString()),
                ],
              ),
            ),
            const Divider(),

            // Coupon Section
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Coupon', style: AppTextStyles.heading3),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Coupon code',
                            prefixIcon: const Icon(Icons.local_offer_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                              borderSide: const BorderSide(color: AppColors.border),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      TextButton(
                        onPressed: _showCoupons,
                        child: const Text('Add', style: TextStyle(color: AppColors.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // Wallet Payment
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pay from Wallet', style: AppTextStyles.heading3),
                  const SizedBox(height: AppSpacing.sm),
                  const Text('Wallet Balance', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: AppSpacing.sm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available for Payment ${currencyFormat.format(_walletBalance)}',
                        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                      ),
                      Switch(
                        value: _useWallet,
                        onChanged: (value) {
                          setState(() {
                            _useWallet = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),

            // Payment Summary
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  _buildDetailRow('Amount ($numberOfDays days)', currencyFormat.format(amount)),
                  const SizedBox(height: AppSpacing.sm),
                  _buildDetailRow('Tax', currencyFormat.format(tax)),
                  const SizedBox(height: AppSpacing.sm),
                  if (_useWallet) ...[
                    _buildDetailRow('Discount', '-${currencyFormat.format(discount)}',
                        valueColor: AppColors.success),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  const Divider(),
                  _buildDetailRow(
                    'Total',
                    currencyFormat.format(total),
                    isTotal: true,
                  ),
                ],
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text('Continue', style: AppTextStyles.button),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.heading3
              : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.heading3.copyWith(color: AppColors.primary)
              : AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
        ),
      ],
    );
  }
}
