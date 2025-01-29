import 'package:fit_bowl_2/domain/entities/sale.dart';
import 'package:fit_bowl_2/domain/usecases/cartusecase/add_sale_to_cart_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/cartusecase/clear_cart.dart_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/cartusecase/get_cart_by_user_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/cartusecase/remove_sale_from_cart_usecase.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/cart.dart';

import 'package:fit_bowl_2/di.dart';

import '../../domain/usecases/cartusecase/create_cart_usecase.dart';

class CartController extends GetxController {
  Cart? userCart;
  bool isLoading = false;
  String errorMessage = '';
  Sale? sale;
  List<Sale> cartSales = [];

  // Create a new cart for a user
  Future<bool> createCart(String userId) async {
    isLoading = true;
    update();

    final res = await CreateCartUseCase(sl())(userId: userId);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to create cart';
        update();
        return false;
      },
      (cart) {
        userCart = cart;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  Future<Cart?> getCartByUserId(String userId) async {
    isLoading = true;

    print('Fetching cart for userId: $userId');

    final res = await GetCartByUserUseCase(sl())(userId);
    isLoading = false;

    return res.fold(
      (failure) {
        // Handle failure, print the error, and return null
        errorMessage = 'Failed to load cart';
        print('Error: ${failure.toString()}');
        update();
        return null; // Return null on failure
      },
      (cart) {
        // Handle success, assign cart data and return the Cart object
        userCart = cart;
        cartSales = cart?.salesIds ?? [];
        print('Fetched Cart: $userCart');
        errorMessage = '';

        return cart; // Return the Cart object on success
      },
    );
  }

  // Add sale to cart
  Future<bool> addSaleToCart(String userId, String saleId) async {
    isLoading = true;
    update();

    final res = await AddSaleToCartUseCase(sl())(userId, saleId);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to add sale to cart';
        update();
        return false;
      },
      (cart) {
        userCart = cart;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Remove sale from cart
  Future<bool> removeSaleFromCart(String userId, String saleId) async {
    isLoading = true;
    update();

    final res = await RemoveSaleFromCartUseCase(sl())(userId, saleId);
    cartSales.removeWhere((sale) => sale.id == saleId);

    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to remove sale from cart';
        update();
        return false;
      },
      (cart) {
        userCart = cart;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Clear the cart
  Future<bool> clearCart(String userId) async {
    isLoading = true;
    update();

    final res = await ClearCartUseCase(sl())(userId);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to clear cart';
        update();
        return false;
      },
      (cart) {
        userCart = cart;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Reset cart state
  void resetCart() {
    userCart = null;
    errorMessage = '';
    update();
  }
}
