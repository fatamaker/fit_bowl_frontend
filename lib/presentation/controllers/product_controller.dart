import 'package:fit_bowl_2/di.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_all_products_usecase.dart';
import 'package:fit_bowl_2/domain/usecases/productusecase/get_productbyid_usecase.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';

// class ProductController extends GetxController {
//   List<Product> allProducts = [];
//   List<Product> filteredProducts = [];
//   String? selectedCategory = 'all'; // Default to "All"
//   Product? selectedProduct; // To store the selected product

//   // Fetch all products
//   Future<bool> getAllProducts() async {
//     if (allProducts.isNotEmpty) {
//       return false;
//     }
//     final res = await GetAllProductsUseCase(sl())();
//     return res.fold(
//       (failure) => false,
//       (products) {
//         allProducts = products;

//         filteredProducts = products; // Initially display all products

//         return true;
//       },
//     );
//   }

//   // Fetch a single product by ID
//   Future<bool> getProductById(String id) async {
//     final res = await GetProductByIdUseCase(sl())(id);

//     res.fold(
//       (failure) {
//         selectedProduct = null;
//         update();
//         return false;
//       },
//       (product) {
//         selectedProduct = product;

//         update();
//         return true;
//       },
//     );
//     return true;
//   }

//   // Filter products based on selected category
//   void filterProducts(String? categoryId) {
//     print("Filtering products for category: $categoryId");
//     if (categoryId == 'all' || categoryId == null) {
//       filteredProducts = allProducts;
//     } else {
//       filteredProducts = allProducts
//           .where((product) => product.category == categoryId)
//           .toList(); // Filter by category
//       print("Filtered products count: ${filteredProducts.length}");
//     }

//     selectedCategory = categoryId;

//     update();
//   }

//   void searchProducts(String word) {
//     List<Product> prd = allProducts;
//     filteredProducts = prd
//         .where((element) =>
//             (element.name!.toUpperCase().contains(word.toUpperCase())))
//         .toList();
//     update();
//   }
// }

class ProductController extends GetxController {
  List<Product> allProducts = [];
  List<Product> filteredProducts = [];
  String selectedCategory = 'all'; // Default to "All"
  Product? selectedProduct; // To store the selected product

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts(); // Fetch products when the controller is initialized
  }

  // Fetch all products
  Future<void> fetchAllProducts() async {
    if (allProducts.isNotEmpty) return; // Avoid redundant API calls

    final res = await GetAllProductsUseCase(sl())();
    res.fold(
      (failure) {
        print('Error fetching products: ${failure.message}');
      },
      (products) {
        allProducts = products;
        filteredProducts = products; // Initially display all products
        update(); // Notify listeners
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

        // update();
        return true;
      },
    );
    return true;
  }

  // Filter products based on selected category
  void filterProducts(String? categoryId) {
    print("Filtering products for category: $categoryId");
    if (categoryId == 'all' || categoryId == null) {
      filteredProducts = allProducts; // Show all products
    } else {
      filteredProducts = allProducts
          .where((product) => product.category == categoryId)
          .toList(); // Filter by category
    }
    print("Filtered products count: ${filteredProducts.length}");

    selectedCategory = categoryId ?? 'all'; // Update selected category
    update(); // Notify listeners
  }

  // Search products by name
  void searchProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = allProducts; // Reset to all products if query is empty
    } else {
      filteredProducts = allProducts
          .where((product) =>
              product.name!.toUpperCase().contains(query.toUpperCase()))
          .toList(); // Filter by name
    }
    update(); // Notify listeners
  }
}

// class ProductController extends GetxController {
//   List<Product> allProducts = [];
//   List<Product> filteredProducts = [];
//   String selectedCategory = 'all'; // Default to "All"
//   Product? selectedProduct; // To store the selected product
//   int? maxCalories; // To store the maximum calorie limit for filtering

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllProducts(); // Fetch products when the controller is initialized
//   }

//   // Fetch all products
//   Future<void> fetchAllProducts() async {
//     if (allProducts.isNotEmpty) return; // Avoid redundant API calls

//     final res = await GetAllProductsUseCase(sl())();
//     res.fold(
//       (failure) {
//         print('Error fetching products: ${failure.message}');
//       },
//       (products) {
//         allProducts = products;
//         filteredProducts = products; // Initially display all products
//         update(); // Notify listeners
//       },
//     );
//   }

//   // Fetch a single product by ID
//   Future<bool> getProductById(String id) async {
//     final res = await GetProductByIdUseCase(sl())(id);

//     res.fold(
//       (failure) {
//         selectedProduct = null;
//         update();
//         return false;
//       },
//       (product) {
//         selectedProduct = product;
//         return true;
//       },
//     );
//     return true;
//   }

//   // Filter products based on selected category
//   void filterProducts(String? categoryId) {
//     print("Filtering products for category: $categoryId");
//     if (categoryId == 'all' || categoryId == null) {
//       filteredProducts = allProducts; // Show all products
//     } else {
//       filteredProducts = allProducts
//           .where((product) => product.category == categoryId)
//           .toList(); // Filter by category
//     }
//     print("Filtered products count: ${filteredProducts.length}");

//     selectedCategory = categoryId ?? 'all'; // Update selected category
//     applyCalorieFilter(); // Apply calorie filter after category filter
//     update(); // Notify listeners
//   }

//   // Search products by name
//   void searchProducts(String query) {
//     if (query.isEmpty) {
//       filteredProducts = allProducts; // Reset to all products if query is empty
//     } else {
//       filteredProducts = allProducts
//           .where((product) =>
//               product.name!.toUpperCase().contains(query.toUpperCase()))
//           .toList(); // Filter by name
//     }
//     applyCalorieFilter(); // Apply calorie filter after search
//     update(); // Notify listeners
//   }

//   // Filter products by calories
//   void filterByCalories(int? maxCalories) {
//     this.maxCalories = maxCalories; // Update the calorie limit
//     applyCalorieFilter(); // Apply the calorie filter
//     update(); // Notify listeners
//   }

//   // Helper method to apply calorie filter
//   void applyCalorieFilter() {
//     if (maxCalories != null) {
//       filteredProducts = filteredProducts.where((product) {
//         // Check if the product has sizes and a small size with calories
//         if (product.sizes != null &&
//             product.sizes!.small != null &&
//             product.sizes!.small!.calories != null) {
//           return product.sizes!.small!.calories! <= maxCalories!;
//         }
//         // Include products without calorie information if no filter is applied
//         return maxCalories == null;
//       }).toList(); // Filter by calories
//     }
//   }

//   // Reset all filters (category, search, and calories)
//   void resetFilters() {
//     selectedCategory = 'all';
//     maxCalories = null;
//     filteredProducts = allProducts; // Reset to all products
//     update(); // Notify listeners
//   }
// }
