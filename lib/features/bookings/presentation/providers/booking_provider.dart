import 'package:flutter/foundation.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/coupon.dart';
import '../../domain/usecases/get_bookings.dart';
import '../../domain/usecases/get_active_bookings.dart';
import '../../domain/usecases/get_completed_bookings.dart';
import '../../domain/usecases/get_booking_by_id.dart';
import '../../domain/usecases/create_booking.dart';
import '../../domain/usecases/cancel_booking.dart';
import '../../domain/usecases/apply_coupon.dart';

/// Booking provider using Clean Architecture use cases
/// Manages booking state and delegates business logic to use cases
class BookingProvider extends ChangeNotifier {
  final GetBookings getBookings;
  final GetActiveBookings getActiveBookings;
  final GetCompletedBookings getCompletedBookings;
  final GetBookingById getBookingById;
  final CreateBooking createBooking;
  final CancelBooking cancelBooking;
  final ApplyCoupon applyCoupon;

  BookingProvider({
    required this.getBookings,
    required this.getActiveBookings,
    required this.getCompletedBookings,
    required this.getBookingById,
    required this.createBooking,
    required this.cancelBooking,
    required this.applyCoupon,
  });

  // State
  List<Booking> _bookings = [];
  List<Booking> _activeBookings = [];
  List<Booking> _completedBookings = [];
  Booking? _selectedBooking;
  Coupon? _appliedCoupon;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Booking> get bookings => _bookings;
  List<Booking> get activeBookings => _activeBookings;
  List<Booking> get completedBookings => _completedBookings;
  Booking? get selectedBooking => _selectedBooking;
  Coupon? get appliedCoupon => _appliedCoupon;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all bookings
  Future<void> loadBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getBookings();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (bookings) {
        _bookings = bookings;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Load active bookings
  Future<void> loadActiveBookings() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getActiveBookings();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (bookings) {
        _activeBookings = bookings;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Load completed bookings
  Future<void> loadCompletedBookings() async {
    final result = await getCompletedBookings();
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        notifyListeners();
      },
      (bookings) {
        _completedBookings = bookings;
        notifyListeners();
      },
    );
  }

  /// Load a single booking by ID
  Future<void> loadBookingById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getBookingById(id);
    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _selectedBooking = null;
        _isLoading = false;
        notifyListeners();
      },
      (booking) {
        _selectedBooking = booking;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  /// Add a new booking
  Future<bool> addBooking(Booking booking) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await createBooking(booking);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (createdBooking) {
        _bookings.add(createdBooking);
        _activeBookings.add(createdBooking);
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Cancel a booking
  Future<bool> cancelBookingById(String bookingId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await cancelBooking(bookingId);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        // Reload bookings after cancellation
        loadBookings();
        loadActiveBookings();
        return true;
      },
    );
  }

  /// Apply coupon code
  Future<bool> applyCouponCode(String couponCode) async {
    _errorMessage = null;
    notifyListeners();

    final result = await applyCoupon(couponCode);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _appliedCoupon = null;
        notifyListeners();
        return false;
      },
      (coupon) {
        _appliedCoupon = coupon;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }

  /// Clear applied coupon
  void clearCoupon() {
    _appliedCoupon = null;
    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Map failure to user-friendly error message
  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server error. Please try again later.';
    } else if (failure is CacheFailure) {
      return 'Unable to load bookings from cache.';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network.';
    } else if (failure is NotFoundFailure) {
      return failure.message;
    } else if (failure is ValidationFailure) {
      return failure.message;
    }
    return 'An unexpected error occurred. Please try again.';
  }
}
