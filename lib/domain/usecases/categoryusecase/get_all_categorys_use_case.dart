import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/category.dart';
import 'package:fit_bowl_2/domain/repository/category_repository.dart';

class GetAllCategoriesUseCase {
  final CategoryRepository _repository;

  const GetAllCategoriesUseCase(this._repository);

  Future<Either<Failure, List<Category>>> call() {
    return _repository.getAllCategories();
  }
}
