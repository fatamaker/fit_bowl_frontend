import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/data/data_source/remote_data_source/wishlist_remote_data_source.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';
import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistRemoteDataSource wishlistRemoteDataSource;

  WishlistRepositoryImpl({required this.wishlistRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> createWishList({required String userId}) async {
    try {
      // ignore: unused_local_variable
      final res = await wishlistRemoteDataSource.createWishList(userId: userId);
      return Right(unit);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Wishlist?>> getWishListById(String userId) async {
    try {
      final wishlist =
          await wishlistRemoteDataSource.getWishlistByUserId(userId);
      return Right(wishlist);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wishlist>> updateWishList(
      String wishlistId, List<String> products) async {
    try {
      final updatedWishlist =
          await wishlistRemoteDataSource.updateWishlist(wishlistId, products);
      return Right(updatedWishlist);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Wishlist>> removeProductFromWishList(
      String userId, String productId) async {
    try {
      final updatedWishlist = await wishlistRemoteDataSource
          .removeProductFromWishlist(userId, productId);
      return Right(updatedWishlist);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
