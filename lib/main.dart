import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:airbnb_booking_app/shared/navigation/main_navigation_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/splash_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/onboarding_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/signup_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/signin_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/otp_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/reset_password_screen.dart';
import 'package:airbnb_booking_app/features/authentication/presentation/screens/country_selection_screen.dart';
import 'package:airbnb_booking_app/features/payments/presentation/screens/payment_method_screen.dart';
import 'package:airbnb_booking_app/features/profile/presentation/screens/refer_friend_screen.dart';
import 'package:airbnb_booking_app/features/settings/presentation/screens/notification_screen.dart';
import 'package:airbnb_booking_app/features/settings/presentation/screens/help_and_faqs_screen.dart';
import 'package:airbnb_booking_app/features/settings/presentation/screens/language_screen.dart';
import 'package:airbnb_booking_app/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:airbnb_booking_app/features/wallet/presentation/screens/add_wallet_screen.dart';
import 'package:airbnb_booking_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:airbnb_booking_app/features/properties/presentation/screens/property_detail_screen.dart';
import 'package:airbnb_booking_app/features/properties/presentation/screens/recommendations_list_screen.dart';
import 'package:airbnb_booking_app/features/properties/presentation/screens/featured_list_screen.dart';
import 'package:airbnb_booking_app/features/chat/presentation/screens/chat_assistant_screen.dart';
import 'package:airbnb_booking_app/features/bookings/presentation/screens/booking_calendar_screen.dart';
import 'package:airbnb_booking_app/features/bookings/presentation/screens/booking_info_screen.dart';
import 'package:airbnb_booking_app/features/bookings/presentation/screens/booking_summary_screen.dart';
import 'package:airbnb_booking_app/features/bookings/presentation/screens/my_bookings_screen.dart';
import 'package:airbnb_booking_app/features/bookings/presentation/screens/e_receipt_screen.dart';
import 'package:airbnb_booking_app/core/theme/app_theme.dart';
import 'package:airbnb_booking_app/core/di/injection_container.dart' as di;
import 'package:airbnb_booking_app/core/di/providers_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await di.init();

  runApp(
    MultiProvider(
      providers: getProviders(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoProperty',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/signin': (context) => const SignInScreen(),
        '/otp': (context) => const OTPScreen(),
        '/reset-password': (context) => const ResetPasswordScreen(),
        '/country-selection': (context) => const CountrySelectionScreen(),
        '/home': (context) => const MainNavigationScreen(),
        '/booking-calendar': (context) => const BookingCalendarScreen(),
        '/booking-info': (context) => const BookingInfoScreen(),
        '/booking-summary': (context) => const BookingSummaryScreen(),
        '/payment-method': (context) => const PaymentMethodScreen(),
        '/my-bookings': (context) => const MyBookingsScreen(),
        '/refer-friend': (context) => const ReferFriendScreen(),
        '/property-detail': (context) => const PropertyDetailScreen(),
        '/e-receipt': (context) => const EReceiptScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/help-and-faqs': (context) => const HelpAndFaqsScreen(),
        '/language': (context) => const LanguageScreen(),
        '/wallet': (context) => const WalletScreen(),
        '/add-wallet': (context) => const AddWalletScreen(),
        '/edit-profile': (context) => const EditProfileScreen(),
        '/recommendations-list': (context) => const RecommendationsListScreen(),
        '/featured-list': (context) => const FeaturedListScreen(),
        '/chat-assistant': (context) => const ChatAssistantScreen(),
      },
    );
  }
}
