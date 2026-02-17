import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/property.dart';
import '../providers/property_provider.dart';

class PropertyDetailScreen extends StatefulWidget {
  const PropertyDetailScreen({super.key});

  @override
  State<PropertyDetailScreen> createState() => _PropertyDetailScreenState();
}

class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final property = ModalRoute.of(context)?.settings.arguments as Property;
    final currencyFormat = NumberFormat.currency(
      symbol: 'GH₵',
      decimalDigits: 0,
    );
    final propertyProvider = context.watch<PropertyProvider>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Image Carousel Header
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppColors.white,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<bool>(
                      future: propertyProvider.checkIsFavorite(property.id),
                      builder: (context, snapshot) {
                        final isFavorite = snapshot.data ?? false;
                        return CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: IconButton(
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite ? Colors.red : AppColors.black,
                            ),
                            onPressed: () {
                              context
                                  .read<PropertyProvider>()
                                  .togglePropertyFavorite(property.id);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'property-image-${property.id}',
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        PageView.builder(
                          itemCount: property.images.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Image.asset(
                              property.images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.border,
                                  child: const Center(
                                    child: Icon(
                                      Icons.home,
                                      size: 80,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        // Page Indicators
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              property.images.length,
                              (index) => Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _currentImageIndex == index
                                      ? AppColors.white
                                      : AppColors.white.withValues(alpha: 0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Property Name and Rating
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              property.name,
                              style: AppTextStyles.heading2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.star.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: AppColors.star,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  property.rating.toString(),
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Property Details
                      Row(
                        children: [
                          _buildPropertyDetail(Icons.bed, '4 Beds'),
                          const SizedBox(width: AppSpacing.lg),
                          _buildPropertyDetail(Icons.bathtub, '4 Bath'),
                          const SizedBox(width: AppSpacing.lg),
                          _buildPropertyDetail(Icons.square_foot, '4000 sqft'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Hosted By
                      const Text('Hosted by', style: AppTextStyles.heading3),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.primary,
                            child: const Text(
                              'H',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          const Expanded(
                            child: Text('Host', style: AppTextStyles.bodyLarge),
                          ),
                          IconButton(
                            icon: Icon(Icons.phone, color: AppColors.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // About This Space
                      const Text(
                        'About this space',
                        style: AppTextStyles.heading3,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        property.description.isNotEmpty
                            ? property.description
                            : 'Discover your own happiness in the city that has it all. Furnished luxury apartment with separate entrance, living room and separate bedroom',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // What This Place Offers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'What this place offers',
                            style: AppTextStyles.heading3,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Amenities Grid
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        children: [
                          _buildAmenityItem(Icons.kitchen, 'Kitchen'),
                          _buildAmenityItem(Icons.pool, 'Pool'),
                          _buildAmenityItem(Icons.wifi, 'Wifi'),
                          _buildAmenityItem(Icons.pets, 'Pet Allow'),
                          _buildAmenityItem(Icons.local_parking, 'Car Parking'),
                          _buildAmenityItem(Icons.grass, 'Garden'),
                          _buildAmenityItem(Icons.kitchen, 'Fridge'),
                          _buildAmenityItem(Icons.air, 'Air Allow'),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Gallery
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Gallery', style: AppTextStyles.heading3),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All',
                              style: TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Gallery Images
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 120,
                              margin: const EdgeInsets.only(
                                right: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.md,
                                ),
                                color: AppColors.border,
                                image: DecorationImage(
                                  image: AssetImage(property.images.first),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xl),

                      // Location
                      const Text('Location', style: AppTextStyles.heading3),
                      const SizedBox(height: AppSpacing.md),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 50,
                                    color: AppColors.primary,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    property.fullLocation,
                                    style: AppTextStyles.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom Book Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            currencyFormat.format(property.price),
                            style: AppTextStyles.heading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          if (property.priceType == 'night')
                            const Text(
                              '/night',
                              style: AppTextStyles.bodySmall,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/booking-calendar',
                              arguments: property,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppRadius.md),
                            ),
                          ),
                          child: Text('Book', style: AppTextStyles.button),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
