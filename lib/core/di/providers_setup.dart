import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../features/properties/presentation/providers/property_provider.dart';
import '../../features/bookings/presentation/providers/booking_provider.dart';
import '../../features/authentication/presentation/providers/auth_provider.dart';
import '../../features/payments/presentation/providers/payment_provider.dart';
import '../../features/wallet/presentation/providers/wallet_provider.dart';
import 'injection_container.dart';

/// Get all providers for the app
List<SingleChildWidget> getProviders() {
  return [
    // Properties Provider
    ChangeNotifierProvider<PropertyProvider>(
      create: (_) => PropertyProvider(
        getProperties: sl(),
        getFeaturedProperties: sl(),
        searchProperties: sl(),
        getPropertiesByType: sl(),
        getPropertyById: sl(),
        toggleFavorite: sl(),
        getFavoriteProperties: sl(),
        isFavorite: sl(),
      ),
    ),

    // Bookings Provider
    ChangeNotifierProvider<BookingProvider>(
      create: (_) => BookingProvider(
        getBookings: sl(),
        getActiveBookings: sl(),
        getCompletedBookings: sl(),
        getBookingById: sl(),
        createBooking: sl(),
        cancelBooking: sl(),
        applyCoupon: sl(),
      ),
    ),

    // Authentication Provider
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(
        signIn: sl(),
        signUp: sl(),
        signOut: sl(),
        verifyOtp: sl(),
        sendOtp: sl(),
        resetPassword: sl(),
        getCurrentUser: sl(),
        isSignedIn: sl(),
      ),
    ),

    // Payments Provider
    ChangeNotifierProvider<PaymentProvider>(
      create: (_) => PaymentProvider(
        getPaymentMethods: sl(),
        processPayment: sl(),
      ),
    ),

    // Wallet Provider
    ChangeNotifierProvider<WalletProvider>(
      create: (_) => WalletProvider(
        getWalletBalance: sl(),
        getTransactions: sl(),
        addFunds: sl(),
      ),
    ),
  ];
}
