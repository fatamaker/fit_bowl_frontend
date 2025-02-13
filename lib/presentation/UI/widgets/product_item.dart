import 'package:fit_bowl_2/domain/entities/product.dart';
import 'package:fit_bowl_2/presentation/controllers/authetification_controller.dart';
import 'package:fit_bowl_2/presentation/controllers/wishlist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  const SizedBox(height: 38), // Space for overlapping image
                  // Product Name
                  Text(
                    widget.product.name ?? 'No name available',
                    style: TextStyle(
                      fontSize: 14,
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
                      fontSize: 9,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
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
