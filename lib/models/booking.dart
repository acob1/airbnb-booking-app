import 'property.dart';

class Booking {
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

  Booking({
    required this.id,
    required this.property,
    required this.bookingDate,
    required this.checkIn,
    required this.checkOut,
    required this.numberOfGuests,
    this.noteToOwner,
    this.bookingForSomeone = false,
    this.guestFirstName,
    this.guestLastName,
    this.guestGender,
    this.guestEmail,
    this.guestPhone,
    this.couponCode,
    required this.amount,
    this.tax = 5.0,
    this.discount = 0.0,
    required this.total,
    this.paymentStatus = 'UnPaid',
    this.bookingStatus = 'Active',
    this.paymentMethod,
  });

  int get numberOfDays => checkOut.difference(checkIn).inDays;

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      property: Property.fromJson(json['property']),
      bookingDate: DateTime.parse(json['bookingDate']),
      checkIn: DateTime.parse(json['checkIn']),
      checkOut: DateTime.parse(json['checkOut']),
      numberOfGuests: json['numberOfGuests'],
      noteToOwner: json['noteToOwner'],
      bookingForSomeone: json['bookingForSomeone'] ?? false,
      guestFirstName: json['guestFirstName'],
      guestLastName: json['guestLastName'],
      guestGender: json['guestGender'],
      guestEmail: json['guestEmail'],
      guestPhone: json['guestPhone'],
      couponCode: json['couponCode'],
      amount: json['amount'].toDouble(),
      tax: json['tax']?.toDouble() ?? 5.0,
      discount: json['discount']?.toDouble() ?? 0.0,
      total: json['total'].toDouble(),
      paymentStatus: json['paymentStatus'] ?? 'UnPaid',
      bookingStatus: json['bookingStatus'] ?? 'Active',
      paymentMethod: json['paymentMethod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'property': property.toJson(),
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
}
