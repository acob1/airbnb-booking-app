import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:airbnb_booking_app/screens/splash_screen.dart';
import 'package:airbnb_booking_app/screens/onboarding_screen.dart';
import 'package:airbnb_booking_app/screens/signup_screen.dart';
import 'package:airbnb_booking_app/screens/signin_screen.dart';
import 'package:airbnb_booking_app/screens/otp_screen.dart';
import 'package:airbnb_booking_app/screens/reset_password_screen.dart';
import 'package:airbnb_booking_app/screens/country_selection_screen.dart';
import 'package:airbnb_booking_app/screens/main_navigation_screen.dart';
import 'package:airbnb_booking_app/screens/booking_calendar_screen.dart';
import 'package:airbnb_booking_app/screens/booking_info_screen.dart';
import 'package:airbnb_booking_app/screens/booking_summary_screen.dart';
import 'package:airbnb_booking_app/screens/payment_method_screen.dart';
import 'package:airbnb_booking_app/screens/my_bookings_screen.dart';
import 'package:airbnb_booking_app/screens/refer_friend_screen.dart';
import 'package:airbnb_booking_app/screens/property_detail_screen.dart';
import 'package:airbnb_booking_app/screens/e_receipt_screen.dart';
import 'package:airbnb_booking_app/screens/notification_screen.dart';
import 'package:airbnb_booking_app/screens/help_and_faqs_screen.dart';
import 'package:airbnb_booking_app/screens/language_screen.dart';
import 'package:airbnb_booking_app/screens/wallet_screen.dart';
import 'package:airbnb_booking_app/screens/add_wallet_screen.dart';
import 'package:airbnb_booking_app/providers/property_provider.dart';
import 'package:airbnb_booking_app/providers/booking_provider.dart';
import 'package:airbnb_booking_app/utils/constants.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PropertyProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.white,
        useMaterial3: true,
      ),
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
      },
    );
  }
}
