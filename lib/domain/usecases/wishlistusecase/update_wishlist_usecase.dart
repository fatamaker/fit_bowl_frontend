import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';
import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';

class UpdateWishListUseCase {
  final WishlistRepository _repository;

  const UpdateWishListUseCase(this._repository);

  Future<Either<Failure, Wishlist>> call(String id, List<String> products) {
    return _repository.updateWishList(id, products);
  }
}
