import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';

abstract class WishlistRepository {
  Future<Either<Failure, Wishlist>> createWishList(
      Map<String, dynamic> wishlistData);
  Future<Either<Failure, Wishlist?>> getWishListById(String userId);
  Future<Either<Failure, Wishlist>> removeProductFromWishList(
      String userId, String productId);
  Future<Either<Failure, Wishlist>> updateWishList(
      String wishlistId, List<String> products);
}
