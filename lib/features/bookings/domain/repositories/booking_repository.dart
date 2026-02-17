import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../entities/coupon.dart';

/// Booking repository interface
/// Defines the contract for booking data operations
abstract class BookingRepository {
  /// Get all bookings
  Future<Either<Failure, List<Booking>>> getBookings();

  /// Get active bookings only
  Future<Either<Failure, List<Booking>>> getActiveBookings();

  /// Get completed bookings only
  Future<Either<Failure, List<Booking>>> getCompletedBookings();

  /// Get cancelled bookings only
  Future<Either<Failure, List<Booking>>> getCancelledBookings();

  /// Get a single booking by ID
  Future<Either<Failure, Booking>> getBookingById(String id);

  /// Create a new booking
  Future<Either<Failure, Booking>> createBooking(Booking booking);

  /// Cancel a booking
  Future<Either<Failure, void>> cancelBooking(String bookingId);

  /// Apply coupon to booking
  Future<Either<Failure, Coupon>> applyCoupon(String couponCode);

  /// Validate coupon
  Future<Either<Failure, bool>> validateCoupon(String couponCode);
}
