import 'package:get_it/get_it.dart';
import '../../features/properties/data/datasources/property_local_data_source.dart';
import '../../features/properties/data/datasources/property_remote_data_source.dart';
import '../../features/properties/data/repositories/property_repository_impl.dart';
import '../../features/properties/domain/repositories/property_repository.dart';
import '../../features/properties/domain/usecases/get_properties.dart';
import '../../features/properties/domain/usecases/get_featured_properties.dart';
import '../../features/properties/domain/usecases/search_properties.dart';
import '../../features/properties/domain/usecases/get_properties_by_type.dart';
import '../../features/properties/domain/usecases/get_property_by_id.dart';
import '../../features/properties/domain/usecases/toggle_favorite.dart';
import '../../features/properties/domain/usecases/get_favorite_properties.dart';
import '../../features/properties/domain/usecases/is_favorite.dart';
import '../../features/bookings/data/datasources/booking_local_data_source.dart';
import '../../features/bookings/data/datasources/booking_remote_data_source.dart';
import '../../features/bookings/data/repositories/booking_repository_impl.dart';
import '../../features/bookings/domain/repositories/booking_repository.dart';
import '../../features/bookings/domain/usecases/get_bookings.dart';
import '../../features/bookings/domain/usecases/get_active_bookings.dart';
import '../../features/bookings/domain/usecases/get_completed_bookings.dart';
import '../../features/bookings/domain/usecases/get_booking_by_id.dart';
import '../../features/bookings/domain/usecases/create_booking.dart';
import '../../features/bookings/domain/usecases/cancel_booking.dart';
import '../../features/bookings/domain/usecases/apply_coupon.dart';
import '../../features/authentication/data/datasources/auth_local_data_source.dart';
import '../../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../../features/authentication/data/repositories/auth_repository_impl.dart';
import '../../features/authentication/domain/repositories/auth_repository.dart';
import '../../features/authentication/domain/usecases/sign_in.dart' as auth_sign_in;
import '../../features/authentication/domain/usecases/sign_up.dart' as auth_sign_up;
import '../../features/authentication/domain/usecases/sign_out.dart';
import '../../features/authentication/domain/usecases/verify_otp.dart';
import '../../features/authentication/domain/usecases/send_otp.dart';
import '../../features/authentication/domain/usecases/reset_password.dart' as auth_reset;
import '../../features/authentication/domain/usecases/get_current_user.dart';
import '../../features/authentication/domain/usecases/is_signed_in.dart';
import '../../features/payments/data/datasources/payment_local_data_source.dart';
import '../../features/payments/data/datasources/payment_remote_data_source.dart';
import '../../features/payments/data/repositories/payment_repository_impl.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';
import '../../features/payments/domain/usecases/get_payment_methods.dart';
import '../../features/payments/domain/usecases/process_payment.dart';
import '../../features/wallet/data/datasources/wallet_local_data_source.dart';
import '../../features/wallet/data/datasources/wallet_remote_data_source.dart';
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';
import '../../features/wallet/domain/usecases/get_wallet_balance.dart';
import '../../features/wallet/domain/usecases/get_transactions.dart';
import '../../features/wallet/domain/usecases/add_funds.dart';

/// Service Locator instance
final sl = GetIt.instance;

/// Initialize all dependencies
Future<void> init() async {
  //! Core

  //! Features - Properties

  // Use Cases
  sl.registerLazySingleton(() => GetProperties(sl()));
  sl.registerLazySingleton(() => GetFeaturedProperties(sl()));
  sl.registerLazySingleton(() => SearchProperties(sl()));
  sl.registerLazySingleton(() => GetPropertiesByType(sl()));
  sl.registerLazySingleton(() => GetPropertyById(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoriteProperties(sl()));
  sl.registerLazySingleton(() => IsFavorite(sl()));

  // Repository
  sl.registerLazySingleton<PropertyRepository>(
    () => PropertyRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<PropertyRemoteDataSource>(
    () => PropertyRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PropertyLocalDataSource>(
    () => PropertyLocalDataSourceImpl(),
  );

  //! Features - Bookings

  // Use Cases
  sl.registerLazySingleton(() => GetBookings(sl()));
  sl.registerLazySingleton(() => GetActiveBookings(sl()));
  sl.registerLazySingleton(() => GetCompletedBookings(sl()));
  sl.registerLazySingleton(() => GetBookingById(sl()));
  sl.registerLazySingleton(() => CreateBooking(sl()));
  sl.registerLazySingleton(() => CancelBooking(sl()));
  sl.registerLazySingleton(() => ApplyCoupon(sl()));

  // Repository
  sl.registerLazySingleton<BookingRepository>(
    () => BookingRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<BookingLocalDataSource>(
    () => BookingLocalDataSourceImpl(),
  );

  //! Features - Authentication

  // Use Cases
  sl.registerLazySingleton(() => auth_sign_in.SignIn(sl()));
  sl.registerLazySingleton(() => auth_sign_up.SignUp(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));
  sl.registerLazySingleton(() => SendOtp(sl()));
  sl.registerLazySingleton(() => auth_reset.ResetPassword(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerLazySingleton(() => IsSignedIn(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  //! Features - Payments

  // Use Cases
  sl.registerLazySingleton(() => GetPaymentMethods(sl()));
  sl.registerLazySingleton(() => ProcessPayment(sl()));

  // Repository
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<PaymentLocalDataSource>(
    () => PaymentLocalDataSourceImpl(),
  );

  //! Features - Wallet

  // Use Cases
  sl.registerLazySingleton(() => GetWalletBalance(sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));
  sl.registerLazySingleton(() => AddFunds(sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<WalletLocalDataSource>(
    () => WalletLocalDataSourceImpl(),
  );

  //! External
}
