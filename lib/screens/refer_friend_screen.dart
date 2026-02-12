import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:airbnb_booking_app/utils/constants.dart';

class ReferFriendScreen extends StatelessWidget {
  const ReferFriendScreen({super.key});

  final String referralCode = '488744';

  void _copyReferralCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Referral code copied to clipboard!')),
    );
  }

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
          'Refer a Friend',
          style: TextStyle(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xl),
            // Referral Illustration
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Central phone
                    Container(
                      width: 80,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 40,
                          ),
                          const SizedBox(height: 4),
                          Icon(
                            Icons.card_giftcard,
                            color: AppColors.star,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    // Surrounding user icons
                    ...List.generate(5, (index) {
                      final radius = 80.0;
                      return Positioned(
                        left: 100 + radius * (1 + (0.7 * (index.isEven ? 1 : -1))) * (index.isOdd ? 0.5 : 1),
                        top: 100 + radius * (1 - (index / 5) * 2) * 0.5,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: index.isEven ? AppColors.star : AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Title
            const Text(
              'Earn ₹10 for Each\nFriend you refer',
              style: AppTextStyles.heading2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),

            // Benefits
            _buildBenefit(
              icon: Icons.share,
              color: AppColors.primary,
              text: 'Share the referral link with your friends',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildBenefit(
              icon: Icons.check_circle,
              color: AppColors.primary,
              text: 'Friend get ₹10 on their first complete transaction',
            ),
            const SizedBox(height: AppSpacing.md),
            _buildBenefit(
              icon: Icons.account_balance_wallet,
              color: AppColors.primary,
              text: 'You get ₹15 on your wallet',
            ),
            const SizedBox(height: AppSpacing.xxl),

            // Referral Code
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.lg,
              ),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    referralCode,
                    style: AppTextStyles.heading2.copyWith(
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  GestureDetector(
                    onTap: () => _copyReferralCode(context),
                    child: Icon(
                      Icons.copy,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Refer Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // Share referral link
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing referral link...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                ),
                child: Text('Refer a friend', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bodyMedium,
          ),
        ),
      ],
    );
  }
}
