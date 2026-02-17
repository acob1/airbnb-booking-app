class RouteNames {
  // Prevent instantiation
  RouteNames._();

  // Authentication Routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String countrySelection = '/country-selection';
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String otp = '/otp';
  static const String resetPassword = '/reset-password';

  // Main App Routes
  static const String home = '/home';
  static const String search = '/search';
  static const String favorites = '/favorites';
  static const String myBookings = '/my-bookings';
  static const String account = '/account';

  // Property Routes
  static const String propertyDetail = '/property-detail';

  // Booking Routes
  static const String bookingCalendar = '/booking-calendar';
  static const String bookingInfo = '/booking-info';
  static const String bookingSummary = '/booking-summary';
  static const String eReceipt = '/e-receipt';

  // Payment Routes
  static const String paymentMethod = '/payment-method';

  // Wallet Routes
  static const String wallet = '/wallet';
  static const String addWallet = '/add-wallet';

  // Profile Routes
  static const String editProfile = '/edit-profile';
  static const String referFriend = '/refer-friend';

  // Settings Routes
  static const String language = '/language';
  static const String notification = '/notification';
  static const String helpAndFaqs = '/help-and-faqs';
}
