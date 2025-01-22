import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();
  Future<Either<Failure, List<Product>>> getSortedProducts();
  Future<Either<Failure, Product>> getProductById(String id);
  Future<Either<Failure, List<Product>>> getProductsByCategory(String category);
}
