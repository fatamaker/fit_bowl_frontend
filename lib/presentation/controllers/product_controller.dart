// import 'package:fit_bowl_2/di.dart';

// import 'package:fit_bowl_2/domain/usecases/productusecase/get_all_products_usecase.dart';
// import 'package:fit_bowl_2/domain/usecases/productusecase/get_product_bycategory.dart';
// import 'package:fit_bowl_2/domain/usecases/productusecase/get_productbyid_usecase.dart';
// import 'package:fit_bowl_2/domain/usecases/productusecase/get_sorted_product_usecase.dart';

// import 'package:get/get.dart';
// import 'package:fit_bowl_2/domain/entities/product.dart';

// class ProductController extends GetxController {
//   List<Product> allProducts = [];
//   List<Product> sortedProducts = [];
//   List<Product> categoryProducts = [];
//   List<Product> productsList = [];

//   Product? selectedProduct;

//   bool isLoading = false;
//   String errorMessage = '';
//   String currentCategory = 'all';

//   int selectedQuantity = 1;
//   List<bool> selectedAddOns = [];

//   String selectedSize = ''; // Keep the selected size in a regular variable.

//   void resetCategoryFilter() {
//     categoryProducts = List.from(allProducts);
//     update();
//   }

//   // // Fetch all products
//   // Future<bool> getAllProducts() async {
//   //   isLoading = true;
//   //   update();
//   //   final res = await GetAllProductsUseCase(sl())();
//   //   isLoading = false;

//   //   res.fold(
//   //     (failure) {
//   //       errorMessage = 'Failed to load products';
//   //       update();
//   //       return false;
//   //     },
//   //     (products) {
//   //       allProducts = products;
//   //       errorMessage = '';
//   //       update();
//   //       return true;
//   //     },
//   //   );
//   //   update();
//   //   return true;
//   // }

//   // Fetch sorted products
//   Future<bool> getSortedProducts() async {
//     isLoading = true;
//     update();
//     final res = await GetSortedProductsUseCase(sl())();
//     isLoading = false;

//     res.fold(
//       (failure) {
//         errorMessage = 'Failed to load sorted products';
//         update();
//         return false;
//       },
//       (products) {
//         sortedProducts = products;
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );
//     return true;
//   }

//   // Fetch products by category
//   Future<bool> getProductsByCategory(String category) async {
//     isLoading = true;
//     update();
//     final res = await GetProductsByCategoryUseCase(sl())(category);
//     isLoading = false;

//     res.fold(
//       (failure) {
//         errorMessage = 'Failed to load products for this category';
//         update();
//         return false;
//       },
//       (products) {
//         categoryProducts = products;
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );
//     update();
//     return true;
//   }

//   // Method to select size
//   void selectSize(String size) {
//     selectedSize = size; // Store the selected size.
//   }

//   // Fetch a single product by ID
//   Future<bool> getProductById(String id) async {
//     isLoading = true;

//     final res = await GetProductByIdUseCase(sl())(id);
//     isLoading = false;

//     res.fold(
//       (failure) {
//         errorMessage = 'Product not found';
//         selectedProduct = null;
//         update();
//         return false;
//       },
//       (product) {
//         selectedProduct = product;
//         errorMessage = '';
//         update();
//         return true;
//       },
//     );
//     return true;
//   }

// // // Fetch all products (once from the backend)
// //   Future<void> getAllProducts() async {
// //     isLoading = true;
// //     errorMessage = '';

// //     final res = await GetAllProductsUseCase(sl())();
// //     isLoading = false;

// //     res.fold(
// //       (failure) {
// //         errorMessage = 'Failed to load products';
// //       },
// //       (products) {
// //         allProducts = products;
// //         categoryProducts = products; // Initially display all products
// //         errorMessage = '';
// //       },
// //     );
// //   }

//   Future<bool> getAllProducts() async {
//     final res = await GetAllProductsUseCase(sl())();

//     res.fold((l) => print(l.toString()), (r) {
//       productsList = r;
//       print(productsList.length);
//       return allProducts = r;
//     });
//     return true;
//   }

//   // Filter products locally by category
//   void filterProductsByCategory(String category) {
//     if (category == 'all') {
//       categoryProducts = allProducts; // Show all products
//     } else {
//       categoryProducts = allProducts
//           .where((product) => product.category == category)
//           .toList(); // Filter by category
//     }
//     currentCategory = category;
//     update();
//   }
// }

import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_all_products_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_productbyid_usecase.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';

class ProductController extends GetxController {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String? selectedCategory = 'all'; // Default to "All"
  Product? selectedProduct; // To store the selected product

  // Fetch all products
  Future<bool> getAllProducts() async {
    if (allProducts.isNotEmpty) {
      return false;
    }
    final res = await GetAllProductsUseCase(sl())();
    return res.fold(
      (failure) => false,
      (products) {
        allProducts = products;

        filteredProducts = products; // Initially display all products

        return true;
      },
    );
  }

  // Fetch a single product by ID
  Future<bool> getProductById(String id) async {
    final res = await GetProductByIdUseCase(sl())(id);

    res.fold(
      (failure) {
        selectedProduct = null;
        update();
        return false;
      },
      (product) {
        selectedProduct = product;

        update();
        return true;
      },
    );
    return true;
  }

  // Filter products based on selected category
  void filterProducts(String? categoryId) {
    print("Filtering products for category: $categoryId");
    if (categoryId == 'all' || categoryId == null) {
      filteredProducts = allProducts;
    } else {
      filteredProducts = allProducts
          .where((product) => product.category == categoryId)
          .toList(); // Filter by category
      print("Filtered products count: ${filteredProducts.length}");
    }

    selectedCategory = categoryId;

    update();
  }
}
