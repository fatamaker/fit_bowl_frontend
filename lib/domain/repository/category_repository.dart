import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<Either<Failure, Category>> getCategoryById(String categoryId);
  Future<Either<Failure, List<Category>>> getAllCategories();
}
