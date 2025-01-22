import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/domain/repository/product_repository.dart';

class GetProductByIdUseCase {
  final ProductRepository _repository;

  const GetProductByIdUseCase(this._repository);

  Future<Either<Failure, Product>> call(String id) {
    return _repository.getProductById(id);
  }
}
