import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/domain/repository/product_repository.dart';

class GetAllProductsUseCase {
  final ProductRepository _repository;

  const GetAllProductsUseCase(this._repository);

  Future<Either<Failure, List<Product>>> call() {
    return _repository.getAllProducts();
  }
}
