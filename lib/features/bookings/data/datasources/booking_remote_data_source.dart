import '../../../../core/errors/exceptions.dart';
import '../models/booking_model.dart';
import '../models/coupon_model.dart';

/// Abstract interface for remote booking data source
abstract class BookingRemoteDataSource {
  Future<List<BookingModel>> getBookings();
  Future<List<BookingModel>> getActiveBookings();
  Future<List<BookingModel>> getCompletedBookings();
  Future<List<BookingModel>> getCancelledBookings();
  Future<BookingModel> getBookingById(String id);
  Future<BookingModel> createBooking(BookingModel booking);
  Future<void> cancelBooking(String bookingId);
  Future<CouponModel> applyCoupon(String couponCode);
  Future<bool> validateCoupon(String couponCode);
}

/// Implementation of remote booking data source
/// Stub for future API integration
class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  // TODO: Inject HTTP client (e.g., Dio, http package)
  // final Dio client;
  // BookingRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookingModel>> getBookings() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<BookingModel>> getActiveBookings() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<BookingModel>> getCompletedBookings() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<List<BookingModel>> getCancelledBookings() async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<BookingModel> getBookingById(String id) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<CouponModel> applyCoupon(String couponCode) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }

  @override
  Future<bool> validateCoupon(String couponCode) async {
    // TODO: Implement API call
    throw ServerException('API not yet integrated');
  }
}
