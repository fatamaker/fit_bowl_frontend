import 'package:dartz/dartz.dart' hide Order;
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/domain/repository/order_repository.dart';

class PlaceOrderUseCase {
  final OrderRepository _repository;

  const PlaceOrderUseCase(this._repository);

  Future<Either<Failure, Order>> call(
      String userId, String deliveryAddress, String payment) {
    return _repository.placeOrder(userId, deliveryAddress, payment);
  }
}
