import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting all bookings
class GetBookings {
  final BookingRepository repository;

  GetBookings(this.repository);

  Future<Either<Failure, List<Booking>>> call() async {
    return await repository.getBookings();
  }
}
