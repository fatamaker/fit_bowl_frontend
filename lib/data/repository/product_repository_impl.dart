import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/product_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await productRemoteDataSource.getAllProducts();
      return Right(products);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch products."));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getSortedProducts() async {
    try {
      final products = await productRemoteDataSource.getSortedProducts();
      return Right(products);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch sorted products."));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(String id) async {
    try {
      final product = await productRemoteDataSource.getProductById(id);
      return Right(product);
    } on ProductNotFoundException catch (e) {
      return Left(ProductNotFoundFailure(message: e.message));
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch the product."));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String category) async {
    try {
      final products =
          await productRemoteDataSource.getProductsByCategory(category);
      return Right(products);
    } on ServerException {
      return Left(ServerFailure(message: "Failed to fetch products."));
    }
  }
}
