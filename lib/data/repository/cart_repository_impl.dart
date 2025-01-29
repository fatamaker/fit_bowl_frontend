import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/cart_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/cart.dart';
import 'package:fit_bowl_2/domain/repository/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepositoryImpl({required this.cartRemoteDataSource});

  @override
  Future<Either<Failure, Cart>> addSaleToCart(
      String userId, String saleId) async {
    try {
      final cart = await cartRemoteDataSource.addSaleToCart(userId, saleId);
      return Right(cart);
    } on SaleNotFoundException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart?>> getCartByUser(String userId) async {
    try {
      final cart = await cartRemoteDataSource.getCartByUser(userId);

      return Right(cart);
    } on CartNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Cart>> removeSaleFromCart(
      String userId, String saleId) async {
    try {
      final cart =
          await cartRemoteDataSource.removeSaleFromCart(userId, saleId);
      return Right(cart);
    } on SaleNotFoundException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> clearCart(String userId) async {
    try {
      final cart = await cartRemoteDataSource.clearCart(userId);
      return Right(cart);
    } on CartNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Cart>> createCart(String userId) async {
    try {
      final res = await cartRemoteDataSource.createCart(userId);
      return Right(res);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }
}
