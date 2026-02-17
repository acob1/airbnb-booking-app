import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting active bookings only
class GetActiveBookings {
  final BookingRepository repository;

  GetActiveBookings(this.repository);

  Future<Either<Failure, List<Booking>>> call() async {
    return await repository.getActiveBookings();
  }
}
