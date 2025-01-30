import 'package:dartz/dartz.dart' hide Order;
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';

abstract class OrderRepository {
  Future<Either<Failure, Order>> placeOrder(String userId);
  Future<Either<Failure, List<Order>>> getUserOrders(String userId);
  Future<Either<Failure, Order>> updateOrderStatus(
      String orderId, String status);
  Future<Either<Failure, Order>> getOrderById(String orderId);
}
