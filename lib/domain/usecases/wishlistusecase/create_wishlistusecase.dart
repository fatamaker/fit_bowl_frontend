import 'package:dartz/dartz.dart';
import 'package:fit_bowl_2/core/erreur/failure/failures.dart';

import 'package:fit_bowl_2/domain/repository/wishlist_repository.dart';

class CreateWishListUseCase {
  final WishlistRepository _repository;

  const CreateWishListUseCase(this._repository);

  Future<Either<Failure, Unit>> call({required String userId}) async =>
      await _repository.createWishList(userId: userId);
}
