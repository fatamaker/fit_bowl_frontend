import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';
import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';

class RemoveProductWishlistUsecse {
  final WishlistRepository _repository;

  const RemoveProductWishlistUsecse(this._repository);

  Future<Either<Failure, Wishlist>> call(String userId, String productId) {
    return _repository.updateWishList(userId, productId as List<String>);
  }
}
