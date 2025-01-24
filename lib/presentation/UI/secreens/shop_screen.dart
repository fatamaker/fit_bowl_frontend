// // ignore_for_file: unused_local_variable

// import 'package:fit_bowl_2/presentation/UI/secreens/category_product_screen.dart';
// import 'package:fit_bowl_2/presentation/UI/secreens/salade_screen.dart';
// import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
// import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
// import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ShopScreen extends StatefulWidget {
//   const ShopScreen({super.key});

//   @override
//   State<ShopScreen> createState() => _ShopScreenState();
// }

// class _ShopScreenState extends State<ShopScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final CategoryController categoryController = Get.put(CategoryController());
//     final ProductController productController = Get.put(ProductController());

//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverPadding(
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             sliver: SliverToBoxAdapter(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Category fetching logic
//                   GetBuilder<CategoryController>(
//                     builder: (categoryController) {
//                       return FutureBuilder(
//                         future: categoryController.getAllCategories(),
//                         builder: (context, snapshot) {
//                           if (snapshot.hasData) {
//                             if (categoryController.allCategories.isEmpty) {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 10),
//                                 child: Center(
//                                     child: Text('No categories available')),
//                               );
//                             } else {
//                               return Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 8),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           horizontal: 20.0),
//                                       child: Text(
//                                         'Categories',
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontFamily: 'LilitaOne',
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 60,
//                                       child: ListView.builder(
//                                         shrinkWrap: true,
//                                         scrollDirection: Axis.horizontal,
//                                         itemCount: categoryController
//                                             .allCategories.length,
//                                         itemBuilder: (_, index) {
//                                           final category = categoryController
//                                               .allCategories[index];
//                                           return Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 // Navigate to CategoryProductScreen and pass the category
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CategoryProductScreen(
//                                                       category: category,
//                                                     ),
//                                                   ),
//                                                 );
//                                               },
//                                               child: Container(
//                                                 decoration: BoxDecoration(
//                                                   color: Color(0xFFADEBB3),
//                                                   border: Border.all(
//                                                       color: Color(0xFFADEBB3),
//                                                       width: 1.5),
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                 ),
//                                                 height: 50,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Text(category.title),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }
//                           } else if (snapshot.hasError) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: Center(
//                                   child: Text('Error: ${snapshot.error}')),
//                             );
//                           } else if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: Center(
//                                   child: CircularProgressIndicator.adaptive()),
//                             );
//                           } else {
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 10),
//                               child: Center(
//                                   child: Text('No categories available')),
//                             );
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Product fetching logic
//           GetBuilder<ProductController>(
//             init: productController,
//             builder: (productController) {
//               return FutureBuilder(
//                 future: productController.getAllProducts(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     if (productController.allProducts.isEmpty) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Center(child: Text('No products available in ')),
//                       );
//                     } else {
//                       return SliverList(
//                         delegate: SliverChildListDelegate(
//                           [
//                             // Products Header
//                             Padding(
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20.0,
//                                 vertical: 10.0,
//                               ),
//                               child: Text(
//                                 'Products',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontFamily: 'LilitaOne',
//                                 ),
//                               ),
//                             ),
//                             // Products Grid
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 15.0),
//                               child: GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 gridDelegate:
//                                     const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: 10,
//                                   crossAxisSpacing: 10,
//                                   childAspectRatio: 0.75,
//                                 ),
//                                 itemCount: productController.allProducts.length,
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                       onTap: () {
//                                         Navigator.of(context).push(
//                                             MaterialPageRoute(
//                                                 builder: (_) => SaladeScreen(
//                                                     product: productController
//                                                         .allProducts[index])));
//                                       },
//                                       child: ProductItem(
//                                           product: productController
//                                               .allProducts[index]));
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                   } else if (snapshot.hasError) {
//                     return SliverToBoxAdapter(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Center(child: Text('Error: ${snapshot.error}')),
//                       ),
//                     );
//                   } else if (snapshot.connectionState ==
//                       ConnectionState.waiting) {
//                     return SliverToBoxAdapter(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child:
//                             Center(child: CircularProgressIndicator.adaptive()),
//                       ),
//                     );
//                   } else {
//                     return SliverToBoxAdapter(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Center(child: Text('No products available')),
//                       ),
//                     );
//                   }
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: unused_local_variable

import 'package:fit_bowl_2/data/modeles/category_model.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/salade_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    // Automatically fetch all products when the screen loads
    final ProductController productController = Get.put(ProductController());
    productController.getAllProducts();
    productController.currentCategory = 'all'; // Default selected category
  }

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.put(CategoryController());
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category fetching logic
                  GetBuilder<CategoryController>(
                    builder: (categoryController) {
                      return FutureBuilder(
                        future: categoryController.getAllCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            // Add the "All" option to the category list
                            final categories = [
                              CategoryModel(id: 'all', title: 'All'),
                              ...categoryController.allCategories,
                            ];

                            if (categories.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                    child: Text('No categories available')),
                              );
                            } else {
                              return SizedBox(
                                height: 60,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categories.length,
                                  itemBuilder: (_, index) {
                                    final category = categories[index];
                                    final isSelected = productController
                                            .currentCategory ==
                                        category
                                            .id; // Check if category is selected
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Update the selected category and fetch products
                                          if (category.id == 'all') {
                                            productController.getAllProducts();
                                          } else {
                                            productController
                                                .getProductsByCategory(
                                                    category.title);
                                          }
                                          productController.currentCategory =
                                              category
                                                  .id; // Set selected category
                                          productController.update();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(
                                                    0xFFADEBB3) // Selected color
                                                : Colors.white, // Default color
                                            border: Border.all(
                                              color: isSelected
                                                  ? const Color(0xFFADEBB3)
                                                  : Colors.grey,
                                              width: 1.5,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          height: 50,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              child: Text(
                                                category.title,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text('Error: ${snapshot.error}')),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                  child: Text('No categories available')),
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Product fetching logic
          GetBuilder<ProductController>(
            builder: (productController) {
              final isAllCategory = productController.currentCategory == 'all';
              final productsToDisplay = isAllCategory
                  ? productController.allProducts
                  : productController.categoryProducts;

              if (productController.isLoading) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                );
              } else if (productsToDisplay.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                        child: Text('No products available in this category')),
                  ),
                );
              } else {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // Products Header
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        child: Text(
                          'Products',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'LilitaOne',
                          ),
                        ),
                      ),
                      // Products Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: productsToDisplay.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => SaladeScreen(
                                        product: productController
                                            .allProducts[index])));
                              },
                              child: ProductItem(
                                  product: productsToDisplay[index]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
