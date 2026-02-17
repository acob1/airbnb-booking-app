import 'package:flutter/material.dart';
import 'route_names.dart';

/// Centralized routing configuration
/// This will be populated as features are migrated
class AppRouter {
  // Prevent instantiation
  AppRouter._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Authentication Routes
      case RouteNames.splash:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with SplashScreen
        );

      case RouteNames.onboarding:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with OnboardingScreen
        );

      case RouteNames.countrySelection:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with CountrySelectionScreen
        );

      case RouteNames.signIn:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with SignInScreen
        );

      case RouteNames.signUp:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with SignUpScreen
        );

      case RouteNames.otp:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with OtpScreen
        );

      case RouteNames.resetPassword:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with ResetPasswordScreen
        );

      // Main App Routes
      case RouteNames.home:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with HomeScreen
        );

      case RouteNames.search:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with SearchScreen
        );

      case RouteNames.favorites:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with FavoritesScreen
        );

      case RouteNames.myBookings:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with MyBookingsScreen
        );

      case RouteNames.account:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with AccountScreen
        );

      // Property Routes
      case RouteNames.propertyDetail:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with PropertyDetailScreen
        );

      // Booking Routes
      case RouteNames.bookingCalendar:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with BookingCalendarScreen
        );

      case RouteNames.bookingInfo:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with BookingInfoScreen
        );

      case RouteNames.bookingSummary:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with BookingSummaryScreen
        );

      case RouteNames.eReceipt:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with EReceiptScreen
        );

      // Payment Routes
      case RouteNames.paymentMethod:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with PaymentMethodScreen
        );

      // Wallet Routes
      case RouteNames.wallet:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with WalletScreen
        );

      case RouteNames.addWallet:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with AddWalletScreen
        );

      // Profile Routes
      case RouteNames.editProfile:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with EditProfileScreen
        );

      case RouteNames.referFriend:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with ReferFriendScreen
        );

      // Settings Routes
      case RouteNames.language:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with LanguageScreen
        );

      case RouteNames.notification:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with NotificationScreen
        );

      case RouteNames.helpAndFaqs:
        return _buildRoute(
          settings,
          const Placeholder(), // TODO: Replace with HelpAndFaqsScreen
        );

      default:
        return _buildRoute(
          settings,
          Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => page,
    );
  }
}
