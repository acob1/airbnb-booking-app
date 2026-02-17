import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/booking_repository.dart';

/// Use case for cancelling a booking
class CancelBooking {
  final BookingRepository repository;

  CancelBooking(this.repository);

  Future<Either<Failure, void>> call(String bookingId) async {
    return await repository.cancelBooking(bookingId);
  }
}
