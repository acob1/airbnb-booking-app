import 'package:flutter/material.dart';
import 'package:airbnb_booking_app/utils/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Notification',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildNotificationItem(
            title: 'Confirmed Successfully!!',
            timestamp: '2023-02-23 12:29:42.000',
          ),
          _buildNotificationItem(
            title: 'Booking Received!!',
            timestamp: '2023-02-23 15:34:31.000',
          ),
          _buildNotificationItem(
            title: 'Booking Received!!',
            timestamp: '2023-02-23 15:42:12.000',
          ),
          _buildNotificationItem(
            title: 'Booking Received!!',
            timestamp: '2023-02-23 18:35:17.000',
          ),
          _buildNotificationItem(
            title: 'Booking Received!!',
            timestamp: '2023-02-24 12:58:58.000',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String timestamp,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          // Bell Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  timestamp,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
