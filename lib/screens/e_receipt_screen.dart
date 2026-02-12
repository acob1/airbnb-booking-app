import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:airbnb_booking_app/models/booking.dart';
import 'package:airbnb_booking_app/utils/constants.dart';

class EReceiptScreen extends StatelessWidget {
  const EReceiptScreen({super.key});

  void _copyTransactionId(BuildContext context, String transactionId) {
    Clipboard.setData(ClipboardData(text: transactionId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction ID copied to clipboard!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = ModalRoute.of(context)?.settings.arguments as Booking?;
    final dateFormat = DateFormat('yyyy-MM-dd');
    final currencyFormat = NumberFormat.currency(symbol: 'GH₵', decimalDigits: 2);

    // Mock data if booking is null
    final bookingDate = booking?.bookingDate ?? DateTime.now();
    final checkIn = booking?.checkIn ?? DateTime.now();
    final checkOut = booking?.checkOut ?? DateTime.now().add(const Duration(days: 2));
    final numberOfGuests = booking?.numberOfGuests ?? 5;
    final numberOfDays = booking?.numberOfDays ?? checkOut.difference(checkIn).inDays;
    final amount = booking?.amount ?? 6000.0;
    final tax = booking?.tax ?? 5.0;
    final discount = booking?.discount ?? 150.0;
    final walletDiscount = 100.0;
    final total = booking?.total ?? 5755.0;
    final userName = 'joy';
    final userPhone = '+91 7276465975';
    final paymentMethod = booking?.paymentMethod ?? 'Razorpay';
    final transactionId = 'pay_LJSa0PkhEtjuEP';
    final paymentStatus = booking?.paymentStatus ?? 'Paid';

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
          'E-Receipt',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Details Section
            _buildDetailRow('Booking Date', dateFormat.format(bookingDate)),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Check in', dateFormat.format(checkIn)),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Check out', dateFormat.format(checkOut)),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Number Of Guest', numberOfGuests.toString()),
            const SizedBox(height: AppSpacing.xl),

            // Payment Breakdown Section
            _buildDetailRow('Amount ($numberOfDays days)', currencyFormat.format(amount)),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Tax', currencyFormat.format(tax)),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow(
              'Coupon',
              currencyFormat.format(discount),
              valueColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow(
              'Wallet',
              currencyFormat.format(walletDiscount),
              valueColor: AppColors.success,
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow(
              'Total',
              currencyFormat.format(total),
              isTotal: true,
            ),
            const SizedBox(height: AppSpacing.xl),

            // User Details Section
            _buildDetailRow('Name', userName),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Phone Number', userPhone),
            const SizedBox(height: AppSpacing.md),
            _buildDetailRow('Payment Title', paymentMethod),
            const SizedBox(height: AppSpacing.md),

            // Transaction ID with Copy Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transaction ID',
                  style: AppTextStyles.bodyMedium,
                ),
                Row(
                  children: [
                    Text(
                      transactionId,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    GestureDetector(
                      onTap: () => _copyTransactionId(context, transactionId),
                      child: Icon(
                        Icons.copy,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status',
                  style: AppTextStyles.bodyMedium,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    paymentStatus,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isTotal = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.bodyLarge.copyWith(fontWeight: FontWeight.w600)
              : AppTextStyles.bodyMedium,
        ),
        Text(
          value,
          style: isTotal
              ? AppTextStyles.heading3
              : AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: valueColor,
                ),
        ),
      ],
    );
  }
}
