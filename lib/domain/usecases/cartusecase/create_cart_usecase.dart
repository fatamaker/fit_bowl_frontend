import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/cart.dart';
import 'package:fit_bowl_2/domain/repository/cart_repository.dart';

class CreateCartUseCase {
  final CartRepository repository;

  CreateCartUseCase(this.repository);

  Future<Either<Failure, Cart>> call({required String userId}) {
    return repository.createCart(userId);
  }
}
