import 'package:fit_bowl_2/di.dart';

import 'package:fit_bowl_2/domain/usecases/productusecase/get_all_products_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_product_bycategory.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_productbyid_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_sorted_product_usecase.dart';

import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';

class ProductController extends GetxController {
  List<Product> allProducts = [];
  List<Product> sortedProducts = [];
  List<Product> categoryProducts = [];
  Product? selectedProduct;
  bool isLoading = false;
  String errorMessage = '';

  // Fetch all products
  Future<bool> getAllProducts() async {
    isLoading = true;
    update();
    final res = await GetAllProductsUseCase(sl())();
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load products';
        update();
        return false;
      },
      (products) {
        allProducts = products;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Fetch sorted products
  Future<bool> getSortedProducts() async {
    isLoading = true;
    update();
    final res = await GetSortedProductsUseCase(sl())();
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load sorted products';
        update();
        return false;
      },
      (products) {
        sortedProducts = products;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Fetch products by category
  Future<bool> getProductsByCategory(String category) async {
    isLoading = true;
    update();
    final res = await GetProductsByCategoryUseCase(sl())(category);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Failed to load products for this category';
        update();
        return false;
      },
      (products) {
        categoryProducts = products;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }

  // Fetch a single product by ID
  Future<bool> getProductById(String id) async {
    isLoading = true;
    update();
    final res = await GetProductByIdUseCase(sl())(id);
    isLoading = false;

    res.fold(
      (failure) {
        errorMessage = 'Product not found';
        update();
        return false;
      },
      (product) {
        selectedProduct = product;
        errorMessage = '';
        update();
        return true;
      },
    );
    return true;
  }
}
