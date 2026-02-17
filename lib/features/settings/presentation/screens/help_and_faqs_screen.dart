import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_spacing.dart';

class HelpAndFaqsScreen extends StatefulWidget {
  const HelpAndFaqsScreen({super.key});

  @override
  State<HelpAndFaqsScreen> createState() => _HelpAndFaqsScreenState();
}

class _HelpAndFaqsScreenState extends State<HelpAndFaqsScreen> {
  int? _expandedIndex;

  final List<Map<String, String>> _faqs = [
    {
      'question': 'About',
      'answer': 'GoProperty is a comprehensive property booking platform that connects property owners with potential tenants and buyers. We offer a wide range of properties including apartments, houses, villas, and more.',
    },
    {
      'question': 'Apartments, Houses, Tenants, and more... Can I participate?',
      'answer': 'Yes! GoProperty is open to all property owners who want to list their properties for rent or sale. Simply create an account, verify your property ownership, and start listing your properties on our platform.',
    },
    {
      'question': 'Short-term rental notices',
      'answer': 'For short-term rentals, we require a minimum notice period of 24 hours for cancellations. Properties can be booked for as short as one night up to several months depending on the property owner\'s preferences.',
    },
    {
      'question': 'How do I see reviews as a guest/host on the app?',
      'answer': 'To view reviews, navigate to any property detail page. Reviews from previous guests will be displayed at the bottom of the page. As a host, you can view reviews of your properties from your host dashboard.',
    },
    {
      'question': 'About the App',
      'answer': 'GoProperty is a modern property booking application built with Flutter. It provides a seamless experience for browsing, booking, and managing property rentals. Our app is available on both iOS and Android platforms.',
    },
    {
      'question': 'General and Emergency contact',
      'answer': 'For general inquiries, please email us at support@goproperty.com. For emergencies related to active bookings, call our 24/7 hotline at +233-XXX-XXXX. We\'re always here to help!',
    },
    {
      'question': 'Extending expired promotions',
      'answer': 'Expired promotions cannot be automatically extended. However, you can contact our support team at support@goproperty.com to inquire about similar current promotions or special offers that may be available.',
    },
    {
      'question': 'I have found an error on the app, what should I do?',
      'answer': 'We appreciate your feedback! Please report any errors or bugs you encounter by emailing us at bugs@goproperty.com with a detailed description and screenshots if possible. We\'ll work quickly to resolve the issue.',
    },
    {
      'question': 'How do I change the language of my account?',
      'answer': 'To change your language preference, go to Settings > Language & Region and select your preferred language from the available options. The app currently supports English and multiple local languages.',
    },
    {
      'question': 'How to reset my password?',
      'answer': 'To reset your password, click on "Forgot Password" on the sign-in screen. Enter your registered email address and we\'ll send you a verification code. Use the code to create a new password.',
    },
    {
      'question': 'How do I sign up?',
      'answer': 'Signing up is easy! Tap the "Sign Up" button on the welcome screen, fill in your details including name, email, phone number, and create a password. Verify your email and phone number, and you\'re ready to start booking!',
    },
  ];

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
          'Helps & FAQs',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _faqs.length,
        itemBuilder: (context, index) {
          final faq = _faqs[index];
          final isExpanded = _expandedIndex == index;

          return Container(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            faq['question']!,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Text(
                      faq['answer']!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
