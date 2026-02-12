import 'package:flutter/material.dart';
import 'package:airbnb_booking_app/models/booking.dart';
import 'package:airbnb_booking_app/models/property.dart';

class BookingProvider extends ChangeNotifier {
  final List<Booking> _bookings = [
    Booking(
      id: 'BK001',
      property: Property(
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
        description: 'Contemporary villa with garden and modern design',
      ),
      bookingDate: DateTime(2023, 2, 22),
      checkIn: DateTime(2023, 2, 23),
      checkOut: DateTime(2023, 2, 24),
      numberOfGuests: 5,
      amount: 6000,
      tax: 5,
      discount: 150,
      total: 5755,
      paymentStatus: 'UnPaid',
      bookingStatus: 'Active',
      paymentMethod: 'Razorpay',
    ),
    Booking(
      id: 'BK002',
      property: Property(
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
        description: 'Charming farmhouse with pool and outdoor space',
      ),
      bookingDate: DateTime(2023, 2, 20),
      checkIn: DateTime(2023, 2, 21),
      checkOut: DateTime(2023, 2, 23),
      numberOfGuests: 4,
      amount: 12000,
      tax: 5,
      discount: 0,
      total: 12005,
      paymentStatus: 'UnPaid',
      bookingStatus: 'Active',
      paymentMethod: 'Paypal',
    ),
    Booking(
      id: 'BK003',
      property: Property(
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
        description: 'Contemporary villa with garden and modern design',
      ),
      bookingDate: DateTime(2023, 2, 15),
      checkIn: DateTime(2023, 2, 16),
      checkOut: DateTime(2023, 2, 18),
      numberOfGuests: 3,
      amount: 6000,
      tax: 5,
      discount: 0,
      total: 6005,
      paymentStatus: 'Paid',
      bookingStatus: 'Active',
      paymentMethod: 'Razorpay',
    ),
  ];

  List<Booking> get bookings => _bookings;

  List<Booking> get activeBookings =>
      _bookings.where((b) => b.bookingStatus == 'Active').toList();

  List<Booking> get completedBookings =>
      _bookings.where((b) => b.bookingStatus == 'Completed').toList();

  void addBooking(Booking booking) {
    _bookings.add(booking);
    notifyListeners();
  }

  void cancelBooking(String bookingId) {
    final index = _bookings.indexWhere((b) => b.id == bookingId);
    if (index != -1) {
      final booking = _bookings[index];
      final updatedBooking = Booking(
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
      notifyListeners();
    }
  }

  Booking? getBookingById(String id) {
    try {
      return _bookings.firstWhere((b) => b.id == id);
    } catch (e) {
      return null;
    }
  }
}
