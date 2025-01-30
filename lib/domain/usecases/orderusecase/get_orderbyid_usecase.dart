import 'package:dartz/dartz.dart' hide Order;

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/domain/repository/order_repository.dart';

class GetOrderByIdUseCase {
  final OrderRepository _repository;

  const GetOrderByIdUseCase(this._repository);

  Future<Either<Failure, Order>> call(String orderId) {
    return _repository.getOrderById(orderId);
  }
}
