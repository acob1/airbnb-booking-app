import '../../../properties/data/models/property_model.dart';
import '../../domain/entities/booking.dart';

/// Booking model - Extends entity and adds serialization
class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.property,
    required super.bookingDate,
    required super.checkIn,
    required super.checkOut,
    required super.numberOfGuests,
    super.noteToOwner,
    required super.bookingForSomeone,
    super.guestFirstName,
    super.guestLastName,
    super.guestGender,
    super.guestEmail,
    super.guestPhone,
    super.couponCode,
    required super.amount,
    required super.tax,
    required super.discount,
    required super.total,
    required super.paymentStatus,
    required super.bookingStatus,
    super.paymentMethod,
  });

  /// Create BookingModel from JSON
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      property: PropertyModel.fromJson(json['property'] as Map<String, dynamic>),
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      checkIn: DateTime.parse(json['checkIn'] as String),
      checkOut: DateTime.parse(json['checkOut'] as String),
      numberOfGuests: json['numberOfGuests'] as int,
      noteToOwner: json['noteToOwner'] as String?,
      bookingForSomeone: json['bookingForSomeone'] as bool? ?? false,
      guestFirstName: json['guestFirstName'] as String?,
      guestLastName: json['guestLastName'] as String?,
      guestGender: json['guestGender'] as String?,
      guestEmail: json['guestEmail'] as String?,
      guestPhone: json['guestPhone'] as String?,
      couponCode: json['couponCode'] as String?,
      amount: (json['amount'] as num).toDouble(),
      tax: (json['tax'] as num?)?.toDouble() ?? 5.0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num).toDouble(),
      paymentStatus: json['paymentStatus'] as String? ?? 'UnPaid',
      bookingStatus: json['bookingStatus'] as String? ?? 'Active',
      paymentMethod: json['paymentMethod'] as String?,
    );
  }

  /// Convert BookingModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'property': PropertyModel.fromEntity(property).toJson(),
      'bookingDate': bookingDate.toIso8601String(),
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'numberOfGuests': numberOfGuests,
      'noteToOwner': noteToOwner,
      'bookingForSomeone': bookingForSomeone,
      'guestFirstName': guestFirstName,
      'guestLastName': guestLastName,
      'guestGender': guestGender,
      'guestEmail': guestEmail,
      'guestPhone': guestPhone,
      'couponCode': couponCode,
      'amount': amount,
      'tax': tax,
      'discount': discount,
      'total': total,
      'paymentStatus': paymentStatus,
      'bookingStatus': bookingStatus,
      'paymentMethod': paymentMethod,
    };
  }

  /// Create BookingModel from Booking entity
  factory BookingModel.fromEntity(Booking booking) {
    return BookingModel(
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
      bookingStatus: booking.bookingStatus,
      paymentMethod: booking.paymentMethod,
    );
  }
}
