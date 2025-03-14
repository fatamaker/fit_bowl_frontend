import 'package:fit_bowl_2/presentation/UI/secreens/cart_screen.dart';
import 'package:fit_bowl_2/presentation/UI/secreens/salade_screen.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/CategoriesSection.dart';
import 'package:fit_bowl_2/presentation/UI/widgets/product_item.dart';
import 'package:fit_bowl_2/presentation/controllers/cart_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/category_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: CategoriesSection(
                    categoryController: categoryController,
                    productController: productController,
                  ),
                ),
              ),
              // Products section
              GetBuilder<ProductController>(
                builder: (productController) {
                  if (productController.filteredProducts.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child:
                            const Center(child: Text('No products available')),
                      ),
                    );
                  } else {
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 6,
                        childAspectRatio: 0.75,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product =
                              productController.filteredProducts[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      SaladeScreen(product: product),
                                ),
                              );
                            },
                            child: ProductItem(product: product),
                          );
                        },
                        childCount: productController.filteredProducts.length,
                      ),
                    );
                  }
                },
              ),
              // Add padding at the bottom to avoid overlap with the cart button
              SliverPadding(
                padding: const EdgeInsets.only(
                    bottom: 85), // Adjust this value as needed
              ),
            ],
          ),
          // Cart button
          Positioned(
            bottom: 90,
            right: 20,
            child: GetBuilder<CartController>(
              builder: (cartController) {
                return AnimatedScale(
                  scale: cartController.cartSales.isNotEmpty ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: cartController.cartSales.isNotEmpty
                      ? badges.Badge(
                          position:
                              badges.BadgePosition.topEnd(top: -5, end: -5),
                          showBadge: cartController.cartSales.isNotEmpty,
                          badgeContent: Text(
                            cartController.cartSales.length.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red,
                            padding: const EdgeInsets.all(6),
                            borderRadius: BorderRadius.circular(8),
                            elevation: 2,
                          ),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CartPage(),
                                ),
                              );
                            },
                            backgroundColor: Colors.green,
                            child: const Icon(Icons.shopping_cart),
                          ),
                        )
                      : const SizedBox(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class ShopScreen extends StatelessWidget {
//   final CategoryController categoryController = Get.put(CategoryController());
//   final ProductController productController = Get.put(ProductController());
//   final CartController cartController = Get.find();

//   const ShopScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 sliver: SliverToBoxAdapter(
//                   child: Column(
//                     children: [
//                       // Categories Section
//                       CategoriesSection(
//                         categoryController: categoryController,
//                         productController: productController,
//                       ),
//                       // Calorie Filter Slider
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16.0, vertical: 8.0),
//                         child: GetBuilder<ProductController>(
//                           builder: (controller) {
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Max Calories: ${controller.maxCalories ?? 'No Limit'}',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Slider(
//                                   value:
//                                       controller.maxCalories?.toDouble() ?? 0,
//                                   min: 0,
//                                   max: 1000, // Adjust max value as needed
//                                   divisions: 10, // Number of steps
//                                   label: controller.maxCalories?.toString(),
//                                   onChanged: (value) {
//                                     controller.filterByCalories(value.toInt());
//                                   },
//                                 ),
//                                 // Reset Calorie Filter Button
//                                 if (controller.maxCalories != null)
//                                   TextButton(
//                                     onPressed: () {
//                                       controller.filterByCalories(
//                                           null); // Reset calorie filter
//                                     },
//                                     child: Text(
//                                       'Reset Calorie Filter',
//                                       style: TextStyle(
//                                         color: Colors.red,
//                                         fontSize: 14,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               // Products Section
//               GetBuilder<ProductController>(
//                 builder: (productController) {
//                   if (productController.filteredProducts.isEmpty) {
//                     return SliverToBoxAdapter(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child:
//                             const Center(child: Text('No products available')),
//                       ),
//                     );
//                   } else {
//                     return SliverGrid(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         mainAxisSpacing: 8,
//                         crossAxisSpacing: 6,
//                         childAspectRatio: 0.75,
//                       ),
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) {
//                           final product =
//                               productController.filteredProducts[index];
//                           return InkWell(
//                             onTap: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (_) =>
//                                       SaladeScreen(product: product),
//                                 ),
//                               );
//                             },
//                             child: ProductItem(product: product),
//                           );
//                         },
//                         childCount: productController.filteredProducts.length,
//                       ),
//                     );
//                   }
//                 },
//               ),
//               // Add padding at the bottom to avoid overlap with the cart button
//               SliverPadding(
//                 padding: const EdgeInsets.only(
//                     bottom: 85), // Adjust this value as needed
//               ),
//             ],
//           ),
//           // Cart Button
//           Positioned(
//             bottom: 90,
//             right: 20,
//             child: GetBuilder<CartController>(
//               builder: (cartController) {
//                 return AnimatedScale(
//                   scale: cartController.cartSales.isNotEmpty ? 1.0 : 0.0,
//                   duration: const Duration(milliseconds: 300),
//                   child: cartController.cartSales.isNotEmpty
//                       ? badges.Badge(
//                           position:
//                               badges.BadgePosition.topEnd(top: -5, end: -5),
//                           showBadge: cartController.cartSales.isNotEmpty,
//                           badgeContent: Text(
//                             cartController.cartSales.length.toString(),
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           badgeStyle: badges.BadgeStyle(
//                             badgeColor: Colors.red,
//                             padding: const EdgeInsets.all(6),
//                             borderRadius: BorderRadius.circular(8),
//                             elevation: 2,
//                           ),
//                           child: FloatingActionButton(
//                             onPressed: () {
//                               Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                   builder: (context) => CartPage(),
//                                 ),
//                               );
//                             },
//                             backgroundColor: Colors.green,
//                             child: const Icon(Icons.shopping_cart),
//                           ),
//                         )
//                       : const SizedBox(),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
