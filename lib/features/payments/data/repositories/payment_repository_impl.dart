import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/payment_method.dart';
import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_local_data_source.dart';
import '../datasources/payment_remote_data_source.dart';

/// Payment Repository Implementation
/// Implements the domain repository interface using data sources
class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remoteDataSource;
  final PaymentLocalDataSource localDataSource;

  PaymentRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    try {
      // Try remote first (when implemented)
      // For now, use local data source
      final paymentMethods = await localDataSource.getPaymentMethods();
      return Right(paymentMethods);
    } on Exception {
      return const Left(CacheFailure('Failed to load payment methods'));
    }
  }

  @override
  Future<Either<Failure, void>> processPayment({
    required String paymentMethodId,
    required double amount,
    required String bookingId,
  }) async {
    try {
      // Try remote first (when implemented)
      // For now, use local data source
      await localDataSource.processPayment(
        paymentMethodId: paymentMethodId,
        amount: amount,
        bookingId: bookingId,
      );
      return const Right(null);
    } on Exception {
      return const Left(ServerFailure('Payment processing failed'));
    }
  }
}
