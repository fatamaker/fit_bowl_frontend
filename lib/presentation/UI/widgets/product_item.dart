import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ProductItem extends StatelessWidget {
//   final Product product;
//   const ProductItem({super.key, required this.product});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: non_constant_identifier_names
//     final ProductSize = product.sizes!.small;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(15),
//                 topRight: Radius.circular(15),
//               ),
//               child: Image.network(
//                 product.image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     // Product Name
//                     Text(
//                       product.name ?? 'No name available',
//                       style: TextStyle(
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),

//                     // Calories
//                     Text(
//                       '${ProductSize!.calories ?? 0} Cal',
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: ProductSize.calories! > 300
//                             ? const Color.fromARGB(255, 26, 83, 28)
//                             : const Color.fromARGB(255, 125, 33, 33),
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     // Product Description
//                     Text(
//                       product.reference ?? 'No description available',
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         color: Colors.grey[700],
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),

//                     // Price and Favorite Icon
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '${ProductSize.price.toStringAsFixed(2)}D',
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Add favorite functionality here
//                           },
//                           icon: Icon(
//                             Icons.favorite_border,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ProductItem extends StatelessWidget {
//   final Product product;

//   const ProductItem({
//     super.key,
//     required this.product,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Fetch the WishlistController and AuthenticationController instances
//     late WishlistController wishlistController;
//     wishlistController = Get.find();
//     final AuthenticationController authenticationController = Get.find();

//     // Get the current user's wishlist ID
//     final String? currentUserId = authenticationController.currentUser.id;
//     final String? wishlistId =
//         wishlistController.getWishlistIdForUser(currentUserId);

//     // ignore: non_constant_identifier_names
//     final ProductSize = product.sizes?.small;
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
//       child: Container(
//         height: 200, // Fixed height to prevent overflow
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: const Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Image (Circular)
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: ClipOval(
//                       child: Image.network(
//                         product.image,
//                         height: 100, // Adjusted size
//                         width: 100,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 // Product Details
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product Name
//                       Text(
//                         product.name ?? 'No name available',
//                         style: TextStyle(
//                           fontSize: 14.sp,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 5),
//                       // Calories
//                       Text(
//                         '${ProductSize?.calories ?? 0} Cal',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: (ProductSize?.calories ?? 0) > 300
//                               ? const Color.fromARGB(255, 125, 33, 33)
//                               : const Color.fromARGB(255, 49, 137, 52),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       // Product Description
//                       Text(
//                         product.reference ?? 'No description available',
//                         style: TextStyle(
//                           fontSize: 12.sp,
//                           color: Colors.grey[700],
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             // Price and Favorite Icon (Floating)
//             Positioned(
//               bottom: 10,
//               left: 10,
//               child: Text(
//                 '${ProductSize?.price.toStringAsFixed(2) ?? "0.00"}D',
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 10,
//               right: 10,
//               child: IconButton(
//                 onPressed: () async {
//                   if (wishlistId == null) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Failed to fetch wishlist ID'),
//                       ),
//                     );
//                     return;
//                   }

//                   // Add to wishlist
//                   final success = await wishlistController.updateWishlist(
//                     wishlistId,
//                     [product.id],
//                   );

//                   if (success) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text('${product.name} added to wishlist!'),
//                       ),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Failed to add to wishlist'),
//                       ),
//                     );
//                   }
//                 },
//                 icon: Icon(
//                   Icons.favorite_border,
//                   color: Colors.grey[600],
//                   size: 20, // Smaller size for better fit
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late bool isInWishlist;

  @override
  void initState() {
    super.initState();
    // Initialize isInWishlist based on whether the product is in the wishlist
    isInWishlist =
        false; // Set to false initially or based on data from wishlistController
    _checkWishlistStatus();
  }

  void _checkWishlistStatus() {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser.id;
    final String? wishlistId =
        wishlistController.getWishlistIdForUser(currentUserId);

    if (wishlistId != null) {
      // Fetch wishlist and check if the product is in it
      wishlistController.getWishlistByUserId(currentUserId!).then((success) {
        if (success && wishlistController.userWishlist != null) {
          setState(() {
            isInWishlist = wishlistController.userWishlist!.productIds
                .contains(widget.product.id);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find();
    final AuthenticationController authenticationController = Get.find();
    final String? currentUserId = authenticationController.currentUser.id;
    final String? wishlistId =
        wishlistController.getWishlistIdForUser(currentUserId);
    final ProductSize = widget.product.sizes?.small;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 18.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Card Layout
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40), // Space for overlapping image
                  // Product Name
                  Text(
                    widget.product.name ?? 'No name available',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Calories
                  Text(
                    '${ProductSize?.calories ?? 0} Cal',
                    style: TextStyle(
                      fontSize: 14,
                      color: (ProductSize?.calories ?? 0) > 300
                          ? Colors.red
                          : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Product Description
                  Text(
                    widget.product.reference ?? 'No description available',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  // Price and Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${ProductSize?.price.toStringAsFixed(2) ?? "0.00"}D',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (wishlistId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to fetch wishlist ID'),
                              ),
                            );
                            return;
                          }

                          bool success;
                          if (isInWishlist) {
                            success = await wishlistController
                                .removeProductFromWishlist(
                              currentUserId!,
                              widget.product.id,
                            );
                          } else {
                            success = await wishlistController.updateWishlist(
                              wishlistId,
                              [widget.product.id],
                            );
                          }

                          if (success) {
                            setState(() {
                              isInWishlist = !isInWishlist;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isInWishlist
                                    ? '${widget.product.name} added to wishlist!'
                                    : '${widget.product.name} removed from wishlist!'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to update wishlist'),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          isInWishlist ? Icons.favorite : Icons.favorite_border,
                          color: isInWishlist ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Overlapping Product Image
          Positioned(
            top: -30, // Adjust to control the overlap
            left: 20,
            right: 20,
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(widget.product.image),
            ),
          ),
        ],
      ),
    );
  }
}
