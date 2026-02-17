import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/booking.dart';
import '../repositories/booking_repository.dart';

/// Use case for getting a single booking by ID
class GetBookingById {
  final BookingRepository repository;

  GetBookingById(this.repository);

  Future<Either<Failure, Booking>> call(String id) async {
    return await repository.getBookingById(id);
  }
}
