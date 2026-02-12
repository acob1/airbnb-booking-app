import 'package:flutter/material.dart';
import 'package:airbnb_booking_app/utils/constants.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'ENGLISH';

  final List<Map<String, String>> _languages = [
    {'name': 'ENGLISH', 'nativeName': 'ENGLISH'},
    {'name': 'Arabic', 'nativeName': 'عربي'},
    {'name': 'Hindi', 'nativeName': 'हिंदी'},
    {'name': 'Spanish', 'nativeName': 'Spanish'},
    {'name': 'France', 'nativeName': 'France'},
    {'name': 'Germany', 'nativeName': 'Germany'},
    {'name': 'Indonesia', 'nativeName': 'Indonesia'},
    {'name': 'South Africa', 'nativeName': 'South Africa'},
    {'name': 'Turkish', 'nativeName': 'Turkish'},
    {'name': 'Portuguese', 'nativeName': 'Portuguese'},
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
          'Language',
          style: TextStyle(color: AppColors.black),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          // Suggested Section Header
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text(
              'Suggested',
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Language List
          ..._languages.map((language) {
            final isSelected = _selectedLanguage == language['name'];
            return _buildLanguageItem(
              language: language['nativeName']!,
              languageCode: language['name']!,
              isSelected: isSelected,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLanguageItem({
    required String language,
    required String languageCode,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = languageCode;
        });
        // Show confirmation snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language changed to $language'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        margin: const EdgeInsets.only(bottom: AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                language,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.textSecondary,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.circle,
                        size: 12,
                        color: AppColors.white,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
