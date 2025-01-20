import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/category_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/category.dart';
import 'package:fit_bowl_2/domain/repository/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource categoryRemoteDataSource;

  CategoryRepositoryImpl({required this.categoryRemoteDataSource});

  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    try {
      final categories = await categoryRemoteDataSource.getAllCategories();
      return Right(categories);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: 'An unknown error occurred'));
    }
  }

  @override
  Future<Either<Failure, Category>> getCategoryById(String categoryId) async {
    try {
      final category =
          await categoryRemoteDataSource.getCategoryById(categoryId);
      return Right(category);
    } on CategoryNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: 'An unknown error occurred'));
    }
  }
}
