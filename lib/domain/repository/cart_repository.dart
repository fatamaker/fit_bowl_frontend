import 'package:dartz/dartz.dart';

import 'package:fit_bowl_2/core/erreur/failure/failures.dart';
import 'package:fit_bowl_2/domain/entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> addSaleToCart(String userId, String saleId);
  Future<Either<Failure, Cart?>> getCartByUser(String userId);
  Future<Either<Failure, Cart>> removeSaleFromCart(
      String userId, String saleId);
  Future<Either<Failure, Cart>> clearCart(String userId);
  Future<Either<Failure, Cart>> createCart(String userId);
}
