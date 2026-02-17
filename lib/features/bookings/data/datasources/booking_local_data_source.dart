import '../../../../core/errors/exceptions.dart';
import '../../../properties/data/models/property_model.dart';
import '../models/booking_model.dart';
import '../models/coupon_model.dart';

/// Abstract interface for local booking data source
abstract class BookingLocalDataSource {
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

/// Implementation of local booking data source
/// Contains hardcoded booking data (moved from BookingProvider)
class BookingLocalDataSourceImpl implements BookingLocalDataSource {
  // Hardcoded bookings (moved from BookingProvider)
  final List<BookingModel> _bookings = [
    BookingModel(
      id: 'BK001',
      property: const PropertyModel(
        id: '4',
        name: 'SkyVilla',
        location: 'Pune',
        city: 'Pune',
        country: 'India',
        price: 3000,
        priceType: 'night',
        rating: 5.0,
        images: [
          'assets/images/user32212-home-2486092_1920 (1).jpg',
          'assets/images/kaboompics-tap-791172_1920.jpg',
          'assets/images/clickerhappy-kitchen-2165756_1920.jpg',
        ],
        type: 'Villa',
        isFeatured: false,
        isBuyable: false,
        maxGuests: 30,
        description: 'Contemporary villa with garden and modern design',
      ),
      bookingDate: DateTime(2023, 2, 22),
      checkIn: DateTime(2023, 2, 23),
      checkOut: DateTime(2023, 2, 24),
      numberOfGuests: 5,
      bookingForSomeone: false,
      amount: 6000,
      tax: 5,
      discount: 150,
      total: 5755,
      paymentStatus: 'UnPaid',
      bookingStatus: 'Active',
      paymentMethod: 'Razorpay',
    ),
    BookingModel(
      id: 'BK002',
      property: const PropertyModel(
        id: '5',
        name: 'Pearl Farm',
        location: 'Pune',
        city: 'Pune',
        country: 'India',
        price: 10000,
        priceType: 'night',
        rating: 5.0,
        images: [
          'assets/images/justinedgecreative-home-5835289_1920.jpg',
          'assets/images/23555986-bedroom-6778193_1920.jpg',
          'assets/images/pexels-chairs-2181968_1920.jpg',
        ],
        type: 'House',
        isFeatured: false,
        isBuyable: false,
        maxGuests: 30,
        description: 'Charming farmhouse with pool and outdoor space',
      ),
      bookingDate: DateTime(2023, 2, 20),
      checkIn: DateTime(2023, 2, 21),
      checkOut: DateTime(2023, 2, 23),
      numberOfGuests: 4,
      bookingForSomeone: false,
      amount: 12000,
      tax: 5,
      discount: 0,
      total: 12005,
      paymentStatus: 'UnPaid',
      bookingStatus: 'Active',
      paymentMethod: 'Paypal',
    ),
    BookingModel(
      id: 'BK003',
      property: const PropertyModel(
        id: '4',
        name: 'SkyVilla',
        location: 'Pune',
        city: 'Pune',
        country: 'India',
        price: 3000,
        priceType: 'night',
        rating: 5.0,
        images: [
          'assets/images/user32212-home-2486092_1920 (1).jpg',
          'assets/images/kaboompics-tap-791172_1920.jpg',
          'assets/images/clickerhappy-kitchen-2165756_1920.jpg',
        ],
        type: 'Villa',
        isFeatured: false,
        isBuyable: false,
        maxGuests: 30,
        description: 'Contemporary villa with garden and modern design',
      ),
      bookingDate: DateTime(2023, 2, 15),
      checkIn: DateTime(2023, 2, 16),
      checkOut: DateTime(2023, 2, 18),
      numberOfGuests: 3,
      bookingForSomeone: false,
      amount: 6000,
      tax: 5,
      discount: 0,
      total: 6005,
      paymentStatus: 'Paid',
      bookingStatus: 'Active',
      paymentMethod: 'Razorpay',
    ),
  ];

  // Hardcoded coupons
  final List<CouponModel> _coupons = [
    CouponModel(
      id: 'C001',
      code: 'SAVE10',
      description: 'Get 10% off on your booking',
      discountPercentage: 10.0,
      maxDiscountAmount: 500.0,
      expiryDate: DateTime(2025, 12, 31),
      isActive: true,
    ),
    CouponModel(
      id: 'C002',
      code: 'WELCOME20',
      description: 'Welcome offer - 20% off',
      discountPercentage: 20.0,
      maxDiscountAmount: 1000.0,
      expiryDate: DateTime(2025, 12, 31),
      isActive: true,
    ),
  ];

  @override
  Future<List<BookingModel>> getBookings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bookings;
  }

  @override
  Future<List<BookingModel>> getActiveBookings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bookings.where((b) => b.bookingStatus == 'Active').toList();
  }

  @override
  Future<List<BookingModel>> getCompletedBookings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bookings.where((b) => b.bookingStatus == 'Completed').toList();
  }

  @override
  Future<List<BookingModel>> getCancelledBookings() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _bookings.where((b) => b.bookingStatus == 'Cancelled').toList();
  }

  @override
  Future<BookingModel> getBookingById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return _bookings.firstWhere((b) => b.id == id);
    } catch (e) {
      throw NotFoundException('Booking with id $id not found');
    }
  }

  @override
  Future<BookingModel> createBooking(BookingModel booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _bookings.add(booking);
    return booking;
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index == -1) {
      throw NotFoundException('Booking with id $bookingId not found');
    }

    final booking = _bookings[index];
    final updatedBooking = BookingModel(
      id: booking.id,
      property: booking.property,
      bookingDate: booking.bookingDate,
      checkIn: booking.checkIn,
      checkOut: booking.checkOut,
      numberOfGuests: booking.numberOfGuests,
      noteToOwner: booking.noteToOwner,
      bookingForSomeone: booking.bookingForSomeone,
      guestFirstName: booking.guestFirstName,
      guestLastName: booking.guestLastName,
      guestGender: booking.guestGender,
      guestEmail: booking.guestEmail,
      guestPhone: booking.guestPhone,
      couponCode: booking.couponCode,
      amount: booking.amount,
      tax: booking.tax,
      discount: booking.discount,
      total: booking.total,
      paymentStatus: booking.paymentStatus,
      bookingStatus: 'Cancelled',
      paymentMethod: booking.paymentMethod,
    );

    _bookings[index] = updatedBooking;
  }

  @override
  Future<CouponModel> applyCoupon(String couponCode) async {
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      final coupon = _coupons.firstWhere(
        (c) => c.code.toUpperCase() == couponCode.toUpperCase(),
      );

      if (!coupon.isValid) {
        throw ValidationException('Coupon is expired or inactive');
      }

      return coupon;
    } catch (e) {
      if (e is ValidationException) rethrow;
      throw NotFoundException('Coupon code not found');
    }
  }

  @override
  Future<bool> validateCoupon(String couponCode) async {
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      final coupon = _coupons.firstWhere(
        (c) => c.code.toUpperCase() == couponCode.toUpperCase(),
      );
      return coupon.isValid;
    } catch (e) {
      return false;
    }
  }
}
