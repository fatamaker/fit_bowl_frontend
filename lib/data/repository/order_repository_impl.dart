import 'package:dartz/dartz.dart' hide Order;
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/order_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/domain/repository/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRepositoryImpl({required this.orderRemoteDataSource});

  @override
  Future<Either<Failure, Order>> placeOrder(
      String userId, String deliveryAddress, String payment) async {
    try {
      final order = await orderRemoteDataSource.placeOrder(
          userId, deliveryAddress, payment);
      return Right(order);
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Order>>> getUserOrders(String userId) async {
    try {
      final orders = await orderRemoteDataSource.getUserOrders(userId);
      return Right(orders);
    } on NotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> updateOrderStatus(
      String orderId, String status) async {
    try {
      final order =
          await orderRemoteDataSource.updateOrderStatus(orderId, status);
      return Right(order);
    } on BadRequestException catch (e) {
      return Left(BadRequestFailure(message: e.message));
    } on NotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Order>> getOrderById(String orderId) async {
    try {
      final order = await orderRemoteDataSource.getOrderById(orderId);
      return Right(order);
    } on NotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
