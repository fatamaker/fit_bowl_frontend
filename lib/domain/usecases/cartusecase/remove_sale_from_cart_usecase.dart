import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/cart.dart';
import 'package:fit_bowl_2/domain/repository/cart_repository.dart';

class RemoveSaleFromCartUseCase {
  final CartRepository _repository;

  const RemoveSaleFromCartUseCase(this._repository);

  Future<Either<Failure, Cart>> call(String userId, String saleId) {
    return _repository.removeSaleFromCart(userId, saleId);
  }
}
