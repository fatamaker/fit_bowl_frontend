import 'package:fit_bowl_2/presentation/UI/widgets/wishlistcard.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fit_bowl_2/presentation/controllers/product_controller.dart';
import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:lottie/lottie.dart'; // Ensure correct import for Product entity

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late WishlistController _wishlistController;
  late ProductController _productController;
  late String currentUserId;
  bool isLoading = true;
  String errorMessage = '';
  List<Product?> wishlistProducts = [];

  @override
  void initState() {
    super.initState();
    _wishlistController = Get.find();
    _productController = Get.find();

    // Fetch the current user ID from the AuthenticationController
    final AuthenticationController authenticationController = Get.find();
    currentUserId = authenticationController.currentUser.id!;

    // Fetch the wishlist and the products for the current user
    _loadWishlist();
  }

  // Function to load the wishlist and products
  void _loadWishlist() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    // Fetch the wishlist for the current user
    final success =
        await _wishlistController.getWishlistByUserId(currentUserId);
    if (success) {
      await _loadProducts();
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load wishlist';
      });
    }
  }

  // Function to load products based on wishlist data
  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
    });

    final productIds = _wishlistController.userWishlist?.productIds ?? [];

    if (productIds.isEmpty) {
      setState(() {
        wishlistProducts = [];
        isLoading = false;
      });
      return;
    }

    List<Product?> fetchedProducts = [];

    for (String productId in productIds) {
      final success = await _productController.getProductById(productId);
      if (success && _productController.selectedProduct != null) {
        fetchedProducts.add(_productController.selectedProduct);
      }
    }

    setState(() {
      wishlistProducts = fetchedProducts;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wish list',
          style: TextStyle(
            fontFamily: 'LilitaOne',
            fontSize: 25,
            color: Color.fromARGB(255, 13, 11, 11),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 18),
                  ),
                )
              : wishlistProducts.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: wishlistProducts.length,
                      itemBuilder: (context, index) {
                        final product = wishlistProducts[index];
                        return WishlistCard(
                          title: product!.name!,
                          imageUrl: product.image,
                          sizesData: {
                            'Small': {
                              'price': product.sizes!.small!.price
                                  .toDouble(), // Ensure conversion to double
                              'calories':
                                  product.sizes!.small!.calories!.toDouble(),
                            },
                            'Medium': {
                              'price': product.sizes!.medium!.price.toDouble(),
                              'calories':
                                  product.sizes!.medium!.calories!.toDouble(),
                            },
                            'Large': {
                              'price': product.sizes!.large!.price.toDouble(),
                              'calories':
                                  product.sizes!.large!.calories!.toDouble(),
                            },
                          },
                          onRemove: () async {
                            await _wishlistController.removeProductFromWishlist(
                                currentUserId, product.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${product.name} removed from wishlist')),
                            );
                            _loadWishlist();
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assetes/animations/coeur.json',
                            width: 150,
                            height: 150,
                            repeat: false,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'No favored product yet. What are you waiting for? Add one!',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
    );
  }
}

// class WishlistCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final double price;
//   final String imageUrl;

//   const WishlistCard({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//       elevation: 4.0,
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       color: Color.fromARGB(255, 211, 232,
//           213), // Light green background for a fresh, healthy feel
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Image with Favorite Icon
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(12.0),
//                   child: Image.network(
//                     imageUrl,
//                     width: 130,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 16.0),
//             // Details Section
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 4.0),
//                   Text(
//                     description,
//                     style: const TextStyle(
//                       fontSize: 14.0,
//                       color: Colors.black54,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8.0),
//                   Text(
//                     '$price',
//                     style: const TextStyle(
//                       fontSize: 16.0,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               top: 8,
//               right: 8,
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 4.0,
//                     ),
//                   ],
//                 ),
//                 child: IconButton(
//                   icon: const Icon(Icons.favorite_rounded,
//                       color:
//                           Color(0xFF66BB6A)), // A vibrant green for interaction
//                   onPressed: () {},
//                   iconSize: 20.0,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
