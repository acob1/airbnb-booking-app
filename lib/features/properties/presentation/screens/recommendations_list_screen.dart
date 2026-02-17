import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/property_provider.dart';
import '../widgets/property_card.dart';

class RecommendationsListScreen extends StatefulWidget {
  const RecommendationsListScreen({super.key});

  @override
  State<RecommendationsListScreen> createState() =>
      _RecommendationsListScreenState();
}

class _RecommendationsListScreenState extends State<RecommendationsListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PropertyProvider>().loadProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    final propertyProvider = context.watch<PropertyProvider>();
    final properties = propertyProvider.properties;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Our Recommendation',
          style: AppTextStyles.heading3,
        ),
        centerTitle: true,
      ),
      body: propertyProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : properties.isEmpty
              ? const Center(
                  child: Text(
                    'No properties found',
                    style: AppTextStyles.bodyMedium,
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: properties.length,
                  itemBuilder: (context, index) {
                    return PropertyCard(
                      property: properties[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/property-detail',
                          arguments: properties[index],
                        );
                      },
                    );
                  },
                ),
    );
  }
}
