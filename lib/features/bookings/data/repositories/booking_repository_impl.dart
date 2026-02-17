import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/booking.dart';
import '../../domain/entities/coupon.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_data_source.dart';
import '../datasources/booking_remote_data_source.dart';

/// Implementation of BookingRepository
/// Coordinates between remote and local data sources
class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Booking>>> getBookings() async {
    try {
      // Try remote first (when API is available)
      // For now, use local data source
      final bookings = await localDataSource.getBookings();
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get bookings: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getActiveBookings() async {
    try {
      final bookings = await localDataSource.getActiveBookings();
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get active bookings: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getCompletedBookings() async {
    try {
      final bookings = await localDataSource.getCompletedBookings();
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get completed bookings: $e'));
    }
  }

  @override
  Future<Either<Failure, List<Booking>>> getCancelledBookings() async {
    try {
      final bookings = await localDataSource.getCancelledBookings();
      return Right(bookings);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get cancelled bookings: $e'));
    }
  }

  @override
  Future<Either<Failure, Booking>> getBookingById(String id) async {
    try {
      final booking = await localDataSource.getBookingById(id);
      return Right(booking);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to get booking: $e'));
    }
  }

  @override
  Future<Either<Failure, Booking>> createBooking(Booking booking) async {
    try {
      final bookingModel = await localDataSource.createBooking(
        booking as dynamic, // Will be BookingModel when called from presentation
      );
      return Right(bookingModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to create booking: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelBooking(String bookingId) async {
    try {
      await localDataSource.cancelBooking(bookingId);
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to cancel booking: $e'));
    }
  }

  @override
  Future<Either<Failure, Coupon>> applyCoupon(String couponCode) async {
    try {
      final coupon = await localDataSource.applyCoupon(couponCode);
      return Right(coupon);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    } on ValidationException catch (e) {
      return Left(ValidationFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to apply coupon: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> validateCoupon(String couponCode) async {
    try {
      final isValid = await localDataSource.validateCoupon(couponCode);
      return Right(isValid);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure('Failed to validate coupon: $e'));
    }
  }
}
