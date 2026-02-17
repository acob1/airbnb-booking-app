import 'package:equatable/equatable.dart';
import '../../../properties/domain/entities/property.dart';

/// Booking entity - Pure business object
class Booking extends Equatable {
  final String id;
  final Property property;
  final DateTime bookingDate;
  final DateTime checkIn;
  final DateTime checkOut;
  final int numberOfGuests;
  final String? noteToOwner;
  final bool bookingForSomeone;
  final String? guestFirstName;
  final String? guestLastName;
  final String? guestGender;
  final String? guestEmail;
  final String? guestPhone;
  final String? couponCode;
  final double amount;
  final double tax;
  final double discount;
  final double total;
  final String paymentStatus; // 'UnPaid', 'Paid'
  final String bookingStatus; // 'Active', 'Completed', 'Cancelled'
  final String? paymentMethod;

  const Booking({
    required this.id,
    required this.property,
    required this.bookingDate,
    required this.checkIn,
    required this.checkOut,
    required this.numberOfGuests,
    this.noteToOwner,
    required this.bookingForSomeone,
    this.guestFirstName,
    this.guestLastName,
    this.guestGender,
    this.guestEmail,
    this.guestPhone,
    this.couponCode,
    required this.amount,
    required this.tax,
    required this.discount,
    required this.total,
    required this.paymentStatus,
    required this.bookingStatus,
    this.paymentMethod,
  });

  /// Calculate number of days between check-in and check-out
  int get numberOfDays => checkOut.difference(checkIn).inDays;

  @override
  List<Object?> get props => [
        id,
        property,
        bookingDate,
        checkIn,
        checkOut,
        numberOfGuests,
        noteToOwner,
        bookingForSomeone,
        guestFirstName,
        guestLastName,
        guestGender,
        guestEmail,
        guestPhone,
        couponCode,
        amount,
        tax,
        discount,
        total,
        paymentStatus,
        bookingStatus,
        paymentMethod,
      ];
}
