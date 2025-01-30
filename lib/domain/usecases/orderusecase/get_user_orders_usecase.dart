import 'package:dartz/dartz.dart' hide Order;
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/order.dart';
import 'package:fit_bowl_2/domain/repository/order_repository.dart';

class GetUserOrdersUseCase {
  final OrderRepository _repository;

  const GetUserOrdersUseCase(this._repository);

  Future<Either<Failure, List<Order>>> call(String userId) {
    return _repository.getUserOrders(userId);
  }
}
