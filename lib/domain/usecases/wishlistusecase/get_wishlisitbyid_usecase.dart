import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';
import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';

class GetWishListByIdUseCase {
  final WishlistRepository _repository;

  const GetWishListByIdUseCase(this._repository);

  Future<Either<Failure, Wishlist?>> call(String userId) {
    return _repository.getWishListById(userId);
  }
}
