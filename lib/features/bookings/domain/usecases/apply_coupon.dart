import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/coupon.dart';
import '../repositories/booking_repository.dart';

/// Use case for applying a coupon
class ApplyCoupon {
  final BookingRepository repository;

  ApplyCoupon(this.repository);

  Future<Either<Failure, Coupon>> call(String couponCode) async {
    return await repository.applyCoupon(couponCode);
  }
}
