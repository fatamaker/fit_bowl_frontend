import 'package:fit_bowl_2/core/erreur/exception/exceptions.dart';
import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/create_wishlistusecase.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/get_wishlisitbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/remove_product_wishlist_usecse.dart';
import 'package:fit_bowl_2/domain/usecases/wishlistusecase/update_wishlist_usecase.dart';

import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/wishlist.dart';

class WishlistController extends GetxController {
  Wishlist? userWishlist;
  bool isLoading = false;
  String errorMessage = '';

  // Create a wishlist for a user
  Future<bool> createWishlist(String userId) async {
    isLoading = true;
    update();

    final res = await CreateWishListUseCase(sl())(userId: userId);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to create wishlist';
        update();
        return false;
      },
      (_) {
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

// Get wishlist by user ID
  Future<bool> getWishlistByUserId(String userId) async {
    isLoading = true;
    update();
    print('Fetching wishlist for userId: $userId');
    final res = await GetWishListByIdUseCase(sl())(userId);
    print('API call complete, result: $res');
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load wishlist';
        print('Error: ${failure.toString()}');
        update();
        return false;
      },
      (wishlist) {
        userWishlist = wishlist;

        print('Fetched Wishlist: $userWishlist');
        print('Wishlist product IDs: ${userWishlist?.productIds}');

        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  String? getWishlistIdForUser(String? userId) {
    if (userId == null) return null;

    // Assuming `userWishlist` holds the current user's wishlist data
    return userWishlist?.id;
  }

  // Update wishlist with new products
  Future<bool> updateWishlist(String wishlistId, List<String> products) async {
    isLoading = true;
    update();

    final res = await UpdateWishListUseCase(sl())(wishlistId, products);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = failure is ServerException
            ? failure.message ?? 'Failed to update wishlist'
            : 'Failed to update wishlist';
        update();
        return false;
      },
      (wishlist) {
        userWishlist = wishlist;
        errorMessage = '';
        update();
        return true;
      },
    );

    return true;
  }

  // Remove a product from the wishlist
  Future<bool> removeProductFromWishlist(
      String userId, String productId) async {
    isLoading = true;
    update();

    final res = await RemoveProductWishlistUsecse(sl())(userId, productId);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to remove product from wishlist';
        update();
        return false;
      },
      (wishlist) {
        userWishlist = wishlist;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Reset wishlist state
  void resetWishlist() {
    userWishlist = null;
    errorMessage = '';
    update();
  }
}
